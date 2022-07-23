class BackendService{
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return List.generate(1, (index){
      return {'nagarNigamServices' : query + index.toString()};
    });
  }
}

class nagarNigamService {
  static final List<String> nagarNigamServices = [
    'सफाई',
    'बिजली विभाग'
  ];
  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(nagarNigamServices);
    matches.retainWhere((element) => element.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}