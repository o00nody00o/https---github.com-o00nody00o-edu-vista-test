part of 'course_bloc.dart';

// @immutable
sealed class CourseEvent {}

class CourseFetchEvent extends CourseEvent {
  final CourseModel course;

  CourseFetchEvent(this.course);
}

class CourseOptionChosenEvent extends CourseEvent {
  final CourseOptions courseOptions;

  CourseOptionChosenEvent(this.courseOptions);
}
