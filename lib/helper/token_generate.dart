import 'package:dio/dio.dart';
import 'package:travelapp/core/const.dart';
import 'helper.dart';

class TokenGenerate {
  static final Dio dio = Dio();
  static void setupDio(String username, String password) {
    print("🛠️ generate token");
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("✅ accesstoken");
          final token = Helper.accessToken;
          if (token != null) {
            options.headers["Authorization"] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          print("❌ token error generate");
          final tokenManager = TokenGenerate();
          if (error.response?.statusCode == 401 &&
              !error.requestOptions.extra.containsKey("retry")) {
            final refresh = await tokenManager.refreshNewToken(
              username,
              password,
            );
            if (refresh) {
              final newOptions = error.requestOptions;
              newOptions.headers["Authorization"] =
                  'Bearer ${Helper.accessToken}';
              newOptions.extra["retry"] = true;
              final cloneResponse = await dio.fetch(newOptions);
              return handler.resolve(cloneResponse);
            } else {
              await Helper.clearToken();
              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  static Dio get instance {
    print("📦 TokenGenerate.instance used");
    return dio;
  }

  Future<bool> refreshNewToken(String username, String password) async {
    final refresh = Helper.refreshToken;
    if (refresh == null) return false;

    try {
      final requestBody = {"username": username, "password": password};
      print("refresh token");
      print(requestBody);
      final response = await dio.post(
        '$path_url/utilization/api/auth/login',
        data: requestBody,
      );
      print("🔁 Token refresh request: $requestBody");
     
      final newAccess =response.data["data"]["access_token"];
      final newRefresh = response.data["data"]["access_token"]; // fix if needed
      await Helper.saveTokens(newAccess, newRefresh);
      return true;
     
    } catch (e) {
      print(
        "❗ Refresh error: $e  " +
            dio.options.toString() +
            dio.interceptors.toString(),
      );
      return false;
    }
  }
}
