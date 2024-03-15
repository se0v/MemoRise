import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memorise/features/notes/bloc/notes_bloc.dart';

import '../data/notes.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({
    super.key,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // ignore: non_constant_identifier_names
  AddNote(Notes notes) {
    context.read<NotesBloc>().add(
          AddNote(notes),
        );
  }

  // ignore: non_constant_identifier_names
  RemoveNotes(Notes notes) {
    context.read<NotesBloc>().add(
          RemoveNotes(notes),
        );
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
                  TextEditingController controller1 = TextEditingController();
                  TextEditingController controller2 = TextEditingController();
                  return AlertDialog(
                    title: const Text('Add a Note'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controller1,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          decoration: InputDecoration(
                            hintText: 'Title...',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
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
                          controller: controller2,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          decoration: InputDecoration(
                            hintText: 'Description...',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
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
                              AddNote(
                                Notes(
                                    title: controller1.text,
                                    subtitle: controller2.text),
                              );
                              controller1.text = '';
                              controller2.text = '';
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                ))),
                      )
                    ],
                  );
                });
          },
          child: const Icon(
            Icons.add,
            color: Color(0xFFEFF1F3),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          title: const Text(
            'MemoRise',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state.status == NotesStatus.success) {
                return ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (context, int i) {
                      return Card(
                        color: Theme.of(context).colorScheme.primary,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Slidable(
                            key: const ValueKey(0),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {
                                    RemoveNotes(state.notes[i]);
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(state.notes[i].title),
                              subtitle: Text(state.notes[i].subtitle),
                            )),
                      );
                    });
              } else if (state.status == NotesStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}

// class MemorListCard extends StatelessWidget {
//   const MemorListCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//           color: theme.cardColor, borderRadius: BorderRadius.circular(12)),
//       child: Text(
//         'Card',
//         style: theme.textTheme.bodyLarge,
//       ),
//     );
//   }
// }

// class SearchButton extends StatelessWidget {
//   const SearchButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//           color: theme.hintColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(16)),
//       child: Row(
//         children: [
//           const Icon(Icons.search),
//           const SizedBox(
//             width: 8,
//           ),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search',
//                 hintStyle: TextStyle(
//                   fontSize: 18,
//                   color: theme.hintColor.withOpacity(0.4),
//                   fontWeight: FontWeight.w700,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 10),
//               ),
//               style: TextStyle(
//                 fontSize: 18,
//                 color: theme.hintColor.withOpacity(0.8),
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
