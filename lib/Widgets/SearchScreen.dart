import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/Helpers/Providers/ChaptersProvider.dart';
import 'package:quran_app/Helpers/Providers/SearchQueryProvider.dart';
import 'package:quran_app/Helpers/Providers/VersesProvider.dart';
import '../Helpers/QuranHomeScreenController.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  void _onSearch() async {
    final controller = Provider.of<QuranHomeScreenController>(context, listen: false);
    String query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await Provider.of<Searchqueryprovider>(context, listen: false)
          .fetchSearchQuery(query, controller);
    } catch (e) {
      debugPrint("Search error: $e");
    }

    setState(() => _isLoading = false);
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      Provider.of<Searchqueryprovider>(context, listen: false).searchmodel.results?.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<Searchqueryprovider>(context);
    final chapters = Provider.of<ChaptersProvider>(context);
    final verses = Provider.of<VersesProvider>(context);
    final controller = Provider.of<QuranHomeScreenController>(context);
    final results = searchProvider.searchmodel.results ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("البحث عن آية قرآنية")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: _searchController,
                onSubmitted: (_) => _onSearch(),
                decoration: InputDecoration(
                  hintText: "إبحث ...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: results.isEmpty
                        ? const Center(child: Text("No results found."))
                        : ListView.builder(
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              final result = results[index];
                              if (result.verse_key == null) return const SizedBox();

                              List<String> parts = result.verse_key!.split(":");
                              if (parts.length < 2) return const SizedBox();

                              int? surrah = int.tryParse(parts[0]);
                              int? verse = int.tryParse(parts[1]);

                              if (surrah == null || verse == null || surrah >= chapters.chaptersModel.chapters.length) {
                                return const SizedBox();
                              }

                              return ListTile(
                                title: Text(
                                  result.text ?? "No text",
                                  textAlign: TextAlign.end,
                                ),
                                subtitle: Text(
                                  "سورة: ${chapters.chaptersModel.chapters[surrah].nameArabic} / الآية رقم: $verse",
                                  textAlign: TextAlign.end,
                                ),
                                onTap: () async {
                                  await verses.fetchVerseByKey(result.verse_key!, controller);
                                  if (verses.page != null) {
                                    await verses.fetchVerseByPage(verses.page, controller);
                                  }
                                },
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
