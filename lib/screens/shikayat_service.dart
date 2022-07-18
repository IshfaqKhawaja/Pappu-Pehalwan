class BackendService{
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return List.generate(1, (index){
      return {'shikayat' : query + index.toString()};
    });
  }
}

class ShikayatService {
  static final List<String> shikayat = [
    'सफाई',
    'बिजली विभाग'
  ];
  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(shikayat);
    matches.retainWhere((element) => element.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}