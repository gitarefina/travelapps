import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/features/home/bloc/home_event.dart';
import 'package:travelapp/features/home/bloc/home_state.dart';
import 'package:travelapp/features/home/model/destination_model.dart';
import 'package:travelapp/service/database_service.dart';
import 'package:travelapp/service/destinations_service.dart';
import 'package:travelapp/service/experience_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DestinationsService service;
  final DatabaseService databaseService;
  HomeBloc({required this.service, required this.databaseService})
    : super(HomeState.initial()) {
    on<insertDestinationHistory>((event, emit) async {
      try {
        final service =await databaseService.createDatabaseDestinationHistory(
          event.model,
        );
        emit(state.copyWith(state: HomeStateStatus.success));
      } catch (e) {
        emit(
          state.copyWith(state: HomeStateStatus.error, message: e.toString()),
        );
      }
    });

     on<getDestinationHistory>((event, emit) async {
      try {
        final service =await databaseService.getDestinationHistory(
        );
        emit(state.copyWith(state: HomeStateStatus.success,dataHistory: service));
      } catch (e) {
        emit(
          state.copyWith(state: HomeStateStatus.error, message: e.toString()),
        );
      }
    });

    on<destinationList>((event, emit) async {
      try {

         final destinationService = await service.getDestination();
        if (destinationService["code"] == 200) {
          var data = (destinationService['data'] as List)
              .map((e) => DataDestination.fromJson(e))
              .toList();
          emit(state.copyWith(data: data, state: HomeStateStatus.success));
        } else {
          emit(
            state.copyWith(
              state: HomeStateStatus.error,
              message: destinationService["message"],
            ),
          );
        }
      } catch (e) {
        print(e.toString());
        emit(
          state.copyWith(state: HomeStateStatus.error, message: e.toString()),
        );
      }
    });
  }
}
