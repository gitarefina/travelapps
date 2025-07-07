import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:travelapp/core/const.dart';
import 'package:travelapp/features/experience/model/experience_model.dart';
import 'package:travelapp/features/experience/model/failure.dart';
import 'package:travelapp/features/home/bloc/home_event.dart';
import 'package:travelapp/features/home/model/destination_model.dart';
import 'package:travelapp/helper/helper.dart';

class ExperienceService {
  final dio = Dio();
  Future<Either<Failure, List<Package>>> getExperience(
    int destination_id,
    int page,
  ) async {
    String? token = await Helper.accessToken;
    print("token experience" +token!);

    try {
      var request_body = {
        "type_source": "location",
        "type_id": 3,
        "destination_id": destination_id,
        "min_price": 0,
        "max_price": 10000000000,
        "page": page,
        "order_by": "lowest",
        "reference": "search",
      };

      var response = await dio.post(
        '$path_url/tour/avail/',
        data: request_body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Set the content-length.
          },
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = response.data; // already Map<String, dynamic>
        final experience = ExperienceModel.fromJson(jsonData);

        // Extract the list of packages safely
        final packages = experience.data_experience?.packages ?? [];
        print(packages);
        return Right(packages);
      } else {
        return Left(Failure(message: 'Failed to load data'));
      }
    } on DioException catch (e) {
      var data = e.response?.data;
      String? errorMsg;
      if (data is Map<String, dynamic>) {
        errorMsg =
            data['error']?.toString() ??
            data['message']?.toString() ??
            jsonEncode(data);
        print(errorMsg);
      } else if (data is String) {
        errorMsg = data;
      } else {
        errorMsg = e.message ?? "Unknown Dio error";
      }

      return Left(
        Failure(message: "Dio exception: $errorMsg"),
      ); // ✅ guaranteed String
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  
}
