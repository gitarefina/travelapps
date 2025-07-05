import 'package:dio/dio.dart';
import 'package:travelapp/core/const.dart';

class DestinationService {
  final dio = Dio();
  
  Future<Map<String, dynamic>> getDestination(String token) async {
    try {
      var response = await dio.get(
        '$path_url/tour/destination',

        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Set the content-length.
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      return {"error": e.response};
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> getExperience(
    int destination_id,
    String token,
    int page,
  ) async {
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
      return response.data;
    } on DioException catch (e) {
      return {"error": e.response};
    } catch (e) {
      return {"error": e.toString()};
    }
  }

   Future<String> getToken(String username, String password) async{
    try{
    
     var request_body = {
  	"username" : username,
  	"password" : password
     };
     var response = await dio.post(
        '$path_url/utilization/api/auth/login',
        data: request_body,
       
      );
      return response.data;
  
    } on DioException catch(e){
      return e.response.toString();
    }
  
  
  }
}



