// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edu_vista_test/model/englecture.dart';
import 'package:meta/meta.dart';

part 'lecture_event.dart';
part 'lecture_state.dart';

class LectureBloc extends Bloc<LectureEvent, LectureState> {
  LectureBloc() : super(LectureInitial()) {
    on<LectureChosenEvent>(_onLectureChosen);

    on<LectureEventInitial>((event, emit) {
      emit(LectureInitial());
    });
  }
  FutureOr<void> _onLectureChosen(
      LectureChosenEvent event, Emitter<LectureState> emit) {
    emit(LectureChosenState(event.lecture));
  }
}
