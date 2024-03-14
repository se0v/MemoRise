import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../data/notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends HydratedBloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<NotesStarted>(_onStarted);
    on<AddNote>(_onAddNote);
    on<RemoveNotes>(_onRemoveNotes);
  }

  void _onStarted(
    NotesStarted event,
    Emitter<NotesState> emit,
  ) {
    if (state.status == NotesStatus.success) return;
    emit(state.copyWith(notes: state.notes, status: NotesStatus.success));
  }

  void _onAddNote(
    AddNote event,
    Emitter<NotesState> emit,
  ) {
    emit(state.copyWith(status: NotesStatus.loading));
    try {
      List<Notes> temp = [];
      temp.addAll(state.notes);
      temp.insert(0, event.notes);
      emit(state.copyWith(notes: temp, status: NotesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NotesStatus.error));
    }
  }

  void _onRemoveNotes(
    RemoveNotes event,
    Emitter<NotesState> emit,
  ) {
    emit(state.copyWith(status: NotesStatus.loading));
    try {
      state.notes.remove(event.notes);
      emit(state.copyWith(notes: state.notes, status: NotesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NotesStatus.error));
    }
  }

  @override
  NotesState? fromJson(Map<String, dynamic> json) {
    return NotesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NotesState state) {
    return state.toJson();
  }
}
