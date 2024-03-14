part of 'notes_bloc.dart';

// sealed class NotesState extends Equatable {
//   const NotesState();

//   @override
//   List<Object> get props => [];
// }

// final class NotesInitial extends NotesState {}

enum NotesStatus { initial, loading, success, error }

class NotesState extends Equatable {
  final List<Notes> notes;
  final NotesStatus status;

  const NotesState(
      {this.notes = const <Notes>[], this.status = NotesStatus.initial});

  NotesState copyWith({
    NotesStatus? status,
    List<Notes>? notes,
  }) {
    return NotesState(
        notes: notes ?? this.notes, status: status ?? this.status);
  }

  @override
  factory NotesState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfNotes = (json['note'] as List<dynamic>)
          .map((e) => Notes.fromJson(e as Map<String, dynamic>))
          .toList();

      return NotesState(
          notes: listOfNotes,
          status: NotesStatus.values.firstWhere(
              (element) => element.name.toString() == json['status']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {'note': notes, 'status': status.name};
  }

  @override
  List<Object?> get props => [notes, status];
}
