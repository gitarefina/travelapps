import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/features/experience/bloc/experience_event.dart';
import 'package:travelapp/features/experience/bloc/experience_state.dart';
import 'package:travelapp/helper/helper.dart';
import 'package:travelapp/service/experience_service.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  ExperienceService service;
  ExperienceBloc({required this.service}) : super(ExperienceState.initial()) {

  
    on<getDataExperience>((event, emit) async {
      try {

        print(await Helper.refreshToken);
        if (event.nextPage != null) {
          emit(state.copyWith(state: RequestState.loading));
        }

        final result = await service.getExperience(
          event.destination_id!,
          event.nextPage??state.pageNumber,
        );
        result.fold((l){
          emit(state.copyWith(state: RequestState.failure,message: l.message));

        },(result){
          emit(state.copyWith(experience: [...state.experience,...result],pageNumber:state.pageNumber+1,state: RequestState.success ));

        });
        

      } catch (e) {
        emit(state.copyWith(state: RequestState.failure,message: e.toString()));
      }
    });
  }
}
