import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          title: const Text('MemoRise'),
          //backgroundColor: theme.primaryColor,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child:
                BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
              if (state.status == NotesStatus.success) {
                // const SliverToBoxAdapter(child: SizedBox(height: 16));
                // return SliverList.builder(
                //   itemBuilder: (context, index) => const MemorListCard(),
                // );
                return Container();
              } else if (state.status == NotesStatus.success) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            }
                    //SearchButton(),
                    ),
          ),
          //   const SliverToBoxAdapter(child: SizedBox(height: 16)),
          //   SliverList.builder(
          //     itemBuilder: (context, index) => const MemorListCard(),
        ),
      ],
    );
  }
}

class MemorListCard extends StatelessWidget {
  const MemorListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: theme.cardColor, borderRadius: BorderRadius.circular(12)),
      child: Text(
        'Card',
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: theme.hintColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: theme.hintColor.withOpacity(0.4),
                  fontWeight: FontWeight.w700,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              style: TextStyle(
                fontSize: 18,
                color: theme.hintColor.withOpacity(0.8),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
