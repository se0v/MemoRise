part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class NotesStarted extends NotesEvent {}

class AddNote extends NotesEvent {
  final Notes notes;

  const AddNote(this.notes);

  @override
  List<Object?> get props => [notes];
}

class RemoveNotes extends NotesEvent {
  final Notes notes;

  const RemoveNotes(this.notes);

  @override
  List<Object?> get props => [notes];
}
