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
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

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

    // Filter chapters based on search query
    final filteredChapters =
        chaptersProvider.chaptersModel.chapters.where((chapter) {
          final surahNumber =
              (chaptersProvider.chaptersModel.chapters.indexOf(chapter) + 1)
                  .toString();
          final surahName = chapter.nameArabic.toLowerCase();
          final query = searchQuery.toLowerCase();

          // Filter by Surah number or Surah name
          return surahNumber.contains(query) || surahName.contains(query);
        }).toList();

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              versesProvider.setPage(versesProvider.page + 1);
              versesProvider.fetchVerseByKey(versesProvider.page, controller);
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined),
          ),
          Text(versesProvider.page.toString()),
          IconButton(
            onPressed: () {
              versesProvider.setPage(versesProvider.page - 1);
              versesProvider.fetchVerseByKey(versesProvider.page, controller);
            },
            icon: Icon(Icons.keyboard_arrow_right_outlined),
          ),
        ],
      ),
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'القران الكريم',
              style: TextStyle(fontFamily: "Arabi2", fontSize: 30),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Consumer<QuranHomeScreenController>(
          builder: (context, controller, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){
                        controller.searchingState(!controller.isSearching);
                      },
                      icon: !controller.isSearching ? Icon(Icons.search_outlined) : Icon(Icons.arrow_drop_down)
                      
                      ),
                      Text(
                        "فهرس سور القرآن الكريم",
                        style: TextStyle(fontFamily: "Arabi2", fontSize: 25),
                      ),
                    ],
                  ),
                ),

                controller.isSearching == true ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  10.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'ابحث باسم السورة أو رقمها',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(fontFamily: "Arabi2", fontSize: 25),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ) : Container(),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredChapters.length,
                    itemBuilder: (context, index) {
                      final chapter = filteredChapters[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              versesProvider.fetchVerseByKey(
                                chapter.pages[0],
                                controller,
                              );
                              versesProvider.setPage(chapter.pages[0]);
                              chaptersProvider.setSelectedchapter(
                                chaptersProvider.chaptersModel.chapters.indexOf(
                                  chapter,
                                ),
                              );
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "سورة ${chapter.nameArabic}",
                                  style: TextStyle(
                                    fontFamily: "Arabi2",
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                  " - ${chaptersProvider.chaptersModel.chapters.indexOf(chapter) + 1}",
                                  style: TextStyle(
                                    fontFamily: "Arabi2",
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Consumer<QuranHomeScreenController>(
            builder: (context, controller, child) {
              return (versesProvider.isLoadingVerses || controller.isRetrying)
                  ? const Center(child: CircularProgressIndicator())
                  : (versesProvider.verseskeymodel == null
                      ? const Center(child: Text("No Data Yet"))
                      : Column(
                        children: [
                          Column(
                            children: [
                              Center(
                                child: Text(
                                  chaptersProvider
                                      .chaptersModel
                                      .chapters[chaptersProvider
                                          .selectedchapter]
                                      .nameArabic,
                                  style: TextStyle(
                                    fontFamily: "Arabi2",
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Center(
                                  child:
                                      chaptersProvider.selectedchapter == 0 ||
                                              chaptersProvider
                                                      .chaptersModel
                                                      .chapters[chaptersProvider
                                                          .selectedchapter]
                                                      .pages[0] !=
                                                  versesProvider.page
                                          ? null
                                          : Image.asset(
                                            "assets/images/bismillah.png",
                                            scale: 6,
                                          ),
                                ),
                              ),
                            ],
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
                      ));
            },
          ),
        ),
      ),
    );
  }
}
