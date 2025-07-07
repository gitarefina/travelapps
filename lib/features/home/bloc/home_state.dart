import 'package:equatable/equatable.dart';
import 'package:travelapp/features/home/model/destination_model.dart';

enum HomeStateStatus { error, initial, success, loading }

// ignore: must_be_immutable
class HomeState extends Equatable {
  HomeStateStatus state;
  List<DataDestination> data;
  List<DataDestination> dataHistory;

  String message;

  HomeState({
    required this.state,
    required this.data,
    required this.message,
    required this.dataHistory,
  });

  static HomeState initial() {
    return HomeState(
      state: HomeStateStatus.initial,
      data: [],
      message: "",
      dataHistory: [],
    );
  }

  HomeState copyWith({
    HomeStateStatus? state,
    List<DataDestination>? data,
    String? message,
    List<DataDestination>? dataHistory,
  }) {
    return HomeState(
      state: state ?? this.state,
      data: data ?? this.data,
      dataHistory: dataHistory ?? this.dataHistory,

      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [state, data, message];
}
