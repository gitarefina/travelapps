import 'package:equatable/equatable.dart';
import 'package:travelapp/features/experience/model/experience_model.dart';

enum RequestState { initial, success, failure,loading}

// ignore: must_be_immutable
class ExperienceState extends Equatable {
  List<Package> experience;
  int pageNumber;
  RequestState state;
  String message;
  ExperienceState({
    required this.experience,
    required this.pageNumber,
    required this.state,
    required this.message
  });

 static ExperienceState initial() {
    return ExperienceState(
      experience: [],
      pageNumber: 1,
      state: RequestState.initial,
      message: ""
    );
  }

  ExperienceState copyWith({
    List<Package>? experience,
    int? pageNumber,
    RequestState? state,  
    String? message,
  }) {
    return ExperienceState(
      experience: experience ?? this.experience,
      pageNumber: pageNumber ?? this.pageNumber,
      state: state ?? this.state,
      message :message ??this.message
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [experience,pageNumber,state];
}

// class ExperienceInitial extends ExperienceState{
  
// }


