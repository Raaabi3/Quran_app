class Apilinks {
  static const String baseurl = "https://quran-com.p.rapidapi.com";
  static const String host = "quran-com.p.rapidapi.com";
  static const String key ="7898dda645msh8320c2b9f9d8bfdp1b6086jsne1c2ffa06c1a";
  static const String ressources = "/resources";
  static const String languages = "$baseurl/resources/languages";
  static String verses(int page) => "$baseurl/verses/by_page/$page";
  static const String chapters = "$baseurl/chapters";
  static const String verse = "$baseurl/quran/verses/imlaei";
  static const String query = "$baseurl/search?q=";
  static String versebykey(String key) => "$baseurl/verses/by_key/$key";






  
}
