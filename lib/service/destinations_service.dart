
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:travelapp/core/const.dart';
import 'package:travelapp/features/home/model/destination_model.dart';
import 'package:travelapp/helper/helper.dart';

class DestinationsService {
  final dio = Dio();
    Future<Map<String, dynamic>> getDestination() async {
    String? token = await Helper.accessToken;
    try {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
      print("request token"+token!);
      var response = await dio.get(
        '$path_url/tour/destination',

        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Set the content-length.
          },
        ),
      );
      var jsonData = response.data; // already Map<String, dynamic>
      final destinationList = DestinationModel.fromJson(jsonData);

      // Extract the list of packages safely
      final packages = destinationList.dataDestination ?? [];

      print("ada datanya ga" + response.data.toString());
      return destinationList.toJson();
    } on DioException catch (e) {
      print(e.toString() + "error");
      return {"error": e.response};
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  
}