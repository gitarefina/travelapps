import 'package:travelapp/database/db.dart';
import 'package:travelapp/features/home/model/destination_model.dart';

class DatabaseService {
  final dbClient = databaseSqlProvider.provider;

  Future<int> createDestination(DataDestination destination) async {
    final db = await dbClient.database;
    await dbClient.createDatabaseAllDestination();

    var result = db.insert("destination", destination.toJson());
    return result;
  }

  Future<int> createDatabaseDestinationHistory(
    DataDestination destination,
  ) async {
    print("check insert database");

    try {

      final db = await dbClient.databaseHistory;

      var result = db.insert("destination_history", destination.toJson());
      print(destination);
      print(result);
      return result;
    } catch (e) {
      print("error insert");
      print(e.toString());
      return 0;
    }
  }

  Future<List<DataDestination>> getAllDestination({
    List<String>? destinationColumn,
  }) async {
    final db = await dbClient.database;

    var result = await db.query("destination", columns: destinationColumn);
    List<DataDestination> model = result.isNotEmpty
        ? result.map((item) => DataDestination.fromJson(item)).toList()
        : [];

    return model;
  }

  Future<List<DataDestination>> getDestinationHistory({
    List<String>? destinationColumn,
  }) async {
    final db = await dbClient.databaseHistory;

    var result = await db.query(
      "destination_history",
      columns: destinationColumn,
    );
    List<DataDestination> model = result.isNotEmpty
        ? result.map((item) => DataDestination.fromJson(item)).toList()
        : [];

    return model;
  }
}
