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
      controller.fetchWithRetry(
        () =>
            Provider.of<ChaptersProvider>(
              context,
              listen: false,
            ).fetchChapters(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final versesProvider = Provider.of<VersesProvider>(context);
    final chaptersProvider = Provider.of<ChaptersProvider>(context);

    return Container(
      decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/Quranborder.jpg",),
      fit: BoxFit.cover,
    ),
  ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
      
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
                      versesProvider.fetchVerseByKey(
                        chapter.pages[0],
                        controller,
                      );
                      chaptersProvider.setSelectedchapter(index);
                    },
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            chapter.nameArabic +
                                    " verse:" +
                                    chapter.pages.toString() ??
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
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Consumer<QuranHomeScreenController>(
            builder: (context, controller, child) {
              return (versesProvider.isLoadingVerses || controller.isRetrying)
                  ? const Center(child: CircularProgressIndicator())
                  : (versesProvider.verseskeymodel == null
                      ? const Center(child: Text("No Data Yet"))
                      : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      chaptersProvider
                                          .chaptersModel
                                          .chapters[chaptersProvider.selectedchapter]
                                          .nameArabic,
                                      style: TextStyle(
                                        fontFamily: "Arabi2",
                                        fontSize: 40,
                                  
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: chaptersProvider.selectedchapter ==  0 ? null : Image.asset("assets/images/bismillah.png",scale: 6,)
                                  ),
                                ],
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      for (final verse
                                          in versesProvider
                                              .verseskeymodel!
                                              .verseKeyModel) ...[
                                        Text(
                                          verse.text_imlaei,
                                          style: TextStyle(
                                            fontFamily: "Arabi2",
                                            fontSize: 30,
                                          ),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Text(
                                              "۝",
                                              style: TextStyle(
                                                fontFamily: "Arabi2",
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Positioned(
                                              child: Directionality(
                                                textDirection: TextDirection.ltr,
                                                child: Text(
                                                  "${verse.verseKey.toString().split(":")[1]}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
            },
          ),
        ),
      ),
    );
  }
}
