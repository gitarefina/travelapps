import 'package:test/test.dart'; // ✅ DO THIS
import 'package:travelapp/core/const.dart';
import 'package:travelapp/helper/token_generate.dart';
import 'package:travelapp/service/destinations_service.dart';
import 'package:travelapp/service/experience_service.dart';

void main() {
  test("description", () async {
    final service = ExperienceService();
    final destinationsService = DestinationsService();
    final serviceToken = TokenGenerate();

    const token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWdpbmctYXBpLm90YXF1LmlkL3V0aWxpemF0aW9uL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzUxODE0ODU5LCJleHAiOjE3NTE4MTg0NTksIm5iZiI6MTc1MTgxNDg1OSwianRpIjoiOFZsTGYxV1VnMTBobVVGOCIsInN1YiI6IjU2IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.WfI4Md3hycmSszq4oUw2PSmacuGW4O2zzHp0ga_2rv4";
    const destinationId = 1270;



    final  servToken = await serviceToken.refreshNewToken(username, password);

    print(servToken);
    final result = await service.getExperience(destinationId, 1);
    result.fold(
      (failure) {
        // Handle the Failure
        printOnFailure("Error: ${failure.message.toString()}");
      },
      (package) {
        // Handle the Package (success)
        if (package.isEmpty) {
          printOnFailure("No packages available.");
        } else {
          printOnFailure("First package name: ${package ?? 'Unnamed'}");
        }
      },
    );

    // printOnFailure('API returned: $result');

    // Force a failure
    // expect(false, isTrue, reason: 'Forced fail');

    final result_destination = await destinationsService.getDestination();
    printOnFailure('API returned: $result_destination');
    // final result_token = await service.getToken(username,password);
    // printOnFailure('API returned token: $result_token');
    // Force a failure
    expect(false, isTrue, reason: 'Forced fail');
  });
}
