import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/Helpers/Providers/LanguagesProvider.dart';
import 'package:quran_app/Helpers/Providers/VersesProvider.dart';
import 'package:quran_app/Helpers/Providers/ChaptersProvider.dart';

class QuranHomeScreen extends StatelessWidget {
  const QuranHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chaptersProvider = Provider.of<ChaptersProvider>(context);
    final versesProvider = Provider.of<VersesProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          chaptersProvider.fetchChapters();
        },
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(title: const Text('Quran App')),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: chaptersProvider.chaptersModel.chapters.length,
          itemBuilder: (context, index) {
            final chapter = chaptersProvider.chaptersModel.chapters[index];
            return ListTile(
              title: Text(chapter.nameArabic ?? 'No chapter name'),
            );
          },
        ),
      ),
    );
  }
}
