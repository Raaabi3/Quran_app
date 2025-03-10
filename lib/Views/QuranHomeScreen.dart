import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/Helpers/Providers/VersesProvider.dart';
import 'package:quran_app/Helpers/Providers/ChaptersProvider.dart';
import '../Helpers/QuranHomeScreenController.dart';

class QuranHomeScreen extends StatefulWidget {
  const QuranHomeScreen({super.key});

  @override
  State<QuranHomeScreen> createState() => _QuranHomeScreenState();
}

class _QuranHomeScreenState extends State<QuranHomeScreen> {
  late QuranHomeScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = QuranHomeScreenController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchWithRetry(() => Provider.of<ChaptersProvider>(context, listen: false).fetchChapters());
    });
  }

  @override
  Widget build(BuildContext context) {
    final versesProvider = Provider.of<VersesProvider>(context);
    final chaptersProvider = Provider.of<ChaptersProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => chaptersProvider.fetchChapters(),
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(title: const Text('Quran App')),
      drawer: Drawer(
        child: Consumer<QuranHomeScreenController>(
          builder: (context, controller, child) {
            return ListView.builder(
              itemCount: chaptersProvider.chaptersModel.chapters.length,
              itemBuilder: (context, index) {
                final chapter = chaptersProvider.chaptersModel.chapters[index];
                return ListTile(
                  onTap: () {
                    versesProvider.fetchVerseByKey(chapter.pages[0], controller);
                  },
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          chapter.nameArabic + " verse:" + chapter.pages.toString() ??
                              'No chapter name',
                        ),
                      ),
                      
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      body: Consumer<QuranHomeScreenController>(
        builder: (context, controller, child) {
          return (versesProvider.isLoadingVerses || controller.isRetrying)
              ? const Center(child: CircularProgressIndicator()) 
              : (versesProvider.verseskeymodel == null
                  ? const Center(child: Text("No Data Yet"))
                  : ListView.builder(
                      itemCount: versesProvider.verseskeymodel!.verseKeyModel.length,
                      itemBuilder: (context, index) {
                        final verse =
                            versesProvider.verseskeymodel!.verseKeyModel[index];
                        return ListTile(title: Text(verse.text_imlaei));
                      },
                    ));
        },
      ),
    );
  }
}