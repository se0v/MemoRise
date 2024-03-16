import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorise/features/notes/bloc/notes_bloc.dart';
import 'package:memorise/features/notes/data/notes.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add a Note'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller1,
                      cursorColor: theme.colorScheme.secondary,
                      decoration: InputDecoration(
                        hintText: 'Title...',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controller2,
                      cursorColor: theme.colorScheme.secondary,
                      decoration: InputDecoration(
                        hintText: 'Description...',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        final newTodo = Notes(
                          title: _controller1.text,
                          subtitle: _controller2.text,
                        );
                        addTodo(newTodo);
                        _controller1.clear();
                        _controller2.clear();
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: theme.colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: theme.colorScheme.secondary,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Icon(
                          Icons.check_box,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Color(0xFFEFF1F3),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.colorScheme.background,
            elevation: 0,
            title: const Text(
              'MemoRise',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state.status == NotesStatus.success) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final note = state.notes[index];
                        return MemorListCard(note: note);
                      },
                      childCount: state.notes.length,
                    ),
                  );
                } else if (state.status == NotesStatus.loading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return SliverFillRemaining(child: Container());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void addTodo(Notes notes) {
    context.read<NotesBloc>().add(
          AddNote(notes),
        );
  }

  void removeTodo(Notes notes) {
    context.read<NotesBloc>().add(
          RemoveNotes(notes),
        );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}

class MemorListCard extends StatelessWidget {
  final Notes note;

  const MemorListCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.background,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.subtitle),
      ),
    );
  }
}
