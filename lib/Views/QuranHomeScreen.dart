import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/Helpers/Providers/SearchQueryProvider.dart';
import 'package:quran_app/Helpers/Providers/VersesProvider.dart';
import 'package:quran_app/Helpers/Providers/ChaptersProvider.dart';
import '../Helpers/QuranHomeScreenController.dart';
import '../Widgets/SearchScreen.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchWithRetry(
        () =>
            Provider.of<ChaptersProvider>(
              context,
              listen: false,
            ).fetchChapters(),
      );
      int savedPage = await controller.loadData();
      if (savedPage != -1) {
        await controller.fetchWithRetry(
          () => Provider.of<VersesProvider>(
            context,
            listen: false,
          ).fetchVerseByPage(savedPage, controller),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuranHomeScreenController>(context);
    final versesProvider = Provider.of<VersesProvider>(context);
    final chaptersProvider = Provider.of<ChaptersProvider>(context);
    final searchProvider = Provider.of<Searchqueryprovider>(context);

    final currentPage = versesProvider.page ?? 1;
    final chapters = chaptersProvider.chaptersModel?.chapters ?? [];
    int currentChapterIndex = chaptersProvider.getChapterIndexByPage(
      currentPage,
    );

    final filteredChapters =
        chapters.where((chapter) {
          final surahNumber = (chapters.indexOf(chapter) + 1).toString();
          final surahName = chapter.nameArabic.toLowerCase();
          final query = searchQuery.toLowerCase();
          return surahNumber.contains(query) || surahName.contains(query);
        }).toList();

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              versesProvider.setPage(currentPage + 1);
              versesProvider.fetchVerseByPage(currentPage + 1, controller);
              controller.saveData(
                currentPage + 1,
                chaptersProvider.selectedchapter,
              );
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined),
          ),
          Text(currentPage.toString()),
          IconButton(
            onPressed: () {
              versesProvider.setPage(currentPage - 1);
              versesProvider.fetchVerseByPage(currentPage - 1, controller);
              controller.saveData(
                currentPage - 1,
                chaptersProvider.selectedchapter,
              );
            },
            icon: Icon(Icons.keyboard_arrow_right_outlined),
          ),
        ],
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
          icon: Icon(Icons.search_outlined),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      IconButton(
                        onPressed: () {
                          controller.searchingState(!controller.isSearching);
                        },
                        icon:
                            !controller.isSearching
                                ? Icon(Icons.search_outlined)
                                : Icon(Icons.arrow_drop_down),
                      ),
                      Text(
                        "فهرس سور القرآن الكريم",
                        style: TextStyle(fontFamily: "Arabi2", fontSize: 25),
                      ),
                    ],
                  ),
                ),
                controller.isSearching == true
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'ابحث باسم السورة أو رقمها',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: TextStyle(
                            fontFamily: "Arabi2",
                            fontSize: 25,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    )
                    : Container(),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredChapters.length,
                    itemBuilder: (context, index) {
                      final chapter = filteredChapters[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              final controller =
                                  Provider.of<QuranHomeScreenController>(
                                    context,
                                    listen: false,
                                  );
                              final versesProvider =
                                  Provider.of<VersesProvider>(
                                    context,
                                    listen: false,
                                  );
                              final chaptersProvider =
                                  Provider.of<ChaptersProvider>(
                                    context,
                                    listen: false,
                                  );
                              versesProvider.fetchVerseByPage(
                                chapter.pages[0],
                                controller,
                              );
                              versesProvider.setPage(chapter.pages[0]);
                              chaptersProvider.setSelectedchapter(
                                chapters.indexOf(chapter),
                              );
                              controller.saveData(
                                chapter.pages[0],
                                chaptersProvider.selectedchapter,
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
                                  " - ${chapters.indexOf(chapter) + 1}",
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
      body: Stack(
        children: [
          // Main Content
              if (!controller.isRetrying && versesProvider.verseskeymodel != null && chapters.isNotEmpty)

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            chapters[currentChapterIndex].nameArabic,
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
                                currentChapterIndex != 0 &&
                                        chapters[currentChapterIndex]
                                                .pages[0] ==
                                            currentPage
                                    ? Image.asset(
                                      "assets/images/bismillah.png",
                                      scale: 6,
                                    )
                                    : null,
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
                ),
              ),
            ),

          // Error Message
          if (controller.errorMessage != null)
            Center(
              child: Text(
                controller.errorMessage!,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),

          // Loading Indicator Overlay
          if (controller.isRetrying)
            AbsorbPointer(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
