import 'package:travelapp/database/db.dart';
import 'package:travelapp/features/home/model/destination_model.dart';

class DatabaseService {
  final dbClient = databaseSqlProvider.provider;

  Future<int> createDestination(DataDestination destination) async {
    final db = await dbClient.database;

    var result = db!.insert("destination", destination.toJson());
    return result;
  }

Future<int> createDatabaseDestinationHistory(DataDestination destination) async {
    final db = await dbClient.database;

    var result = db!.insert("destination_history", destination.toJson());
    return result;
  }

  Future<List<DataDestination>> getAllDestination({
    List<String>? destinationColumn,
  }) async {
    final db = await dbClient.database;

    var result = await db!.query("destination", columns: destinationColumn);
    List<DataDestination> model = result.isNotEmpty
        ? result.map((item) => DataDestination.fromJson(item)).toList()
        : [];

        return model;
  }

  Future<List<DataDestination>> getDestinationHistory({
    List<String>? destinationColumn,
  }) async {
    final db = await dbClient.database;

    var result = await db!.query("destination_history", columns: destinationColumn);
    List<DataDestination> model = result.isNotEmpty
        ? result.map((item) => DataDestination.fromJson(item)).toList()
        : [];

        return model;
  }
}
