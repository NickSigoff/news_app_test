import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_section_event.dart';
part 'current_section_state.dart';

class CurrentSectionBloc extends Bloc<CurrentSectionEvent, int> {
  CurrentSectionBloc() : super(0) {
    on<OnPressTabEvent>((event, emit) => emit(event.index));
  }
}
