import 'package:travelapp/features/home/model/destination_model.dart';
import 'package:travelapp/service/database_service.dart';

class RepositoryDestination {

    final DatabaseService service= DatabaseService();

    Future getDatabaseDestionation() => service.getAllDestination();
    Future getDatabaseDestionationHistory() => service.getDestinationHistory();

    Future insertDatabaseDestination(DataDestination destination)=> service.createDestination(destination);
    Future insertDatabaseDestinationHistory(DataDestination destination)=> service.createDatabaseDestinationHistory(destination);

}