import 'package:test/test.dart'; // ✅ DO THIS
import 'package:travelapp/core/const.dart';
import 'package:travelapp/service/destination_service.dart';

void main() {
  test("description", () async {
    final service = DestinationService();
    const token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWdpbmctYXBpLm90YXF1LmlkL3V0aWxpemF0aW9uL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzUxNzMwMjI4LCJleHAiOjE3NTE3MzM4MjgsIm5iZiI6MTc1MTczMDIyOCwianRpIjoidkZTQW41UmRDekpIZGJLOCIsInN1YiI6IjU2IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.C6VctUVuIDVhKBFb2bxfcw3WJxVsTu8TxjtVV5JG1Qs";
    const destinationId = 1270;

    final result = await service.getExperience(destinationId, token, 1);
    printOnFailure('API returned: $result');

    // Force a failure
    // expect(false, isTrue, reason: 'Forced fail');

    final result_destination = await service.getDestination(token);
    printOnFailure('API returned: $result_destination');
    final result_token = await service.getToken(username,password);
    printOnFailure('API returned token: $result_token');
    // Force a failure
    expect(false, isTrue, reason: 'Forced fail');
  });
}
