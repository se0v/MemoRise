import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:memorise/features/home/home.dart';
import 'package:memorise/features/notes/bloc/notes_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MemoRise());
}

class MemoRise extends StatelessWidget {
  const MemoRise({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 183, 58, 58);
    return MaterialApp(
      title: 'MemoRise',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: const Color(0xFFEFF1F3),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: BlocProvider<NotesBloc>(
        create: (context) => NotesBloc()..add(NotesStarted()),
        child: const HomeScreen(),
      ),
    );
  }
}
