part of 'current_section_bloc.dart';

@immutable
abstract class CurrentSectionEvent {}

class OnPressTabEvent extends CurrentSectionEvent {
  final int index;

  OnPressTabEvent({required this.index});
}
