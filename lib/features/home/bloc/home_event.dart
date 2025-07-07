import 'package:travelapp/features/home/model/destination_model.dart';

abstract class HomeEvent {}

class destinationList extends HomeEvent{
 
  
}

class insertDestinationHistory extends HomeEvent{
  final DataDestination model;

  insertDestinationHistory(this.model);
}

class getDestinationHistory extends HomeEvent{
  
}