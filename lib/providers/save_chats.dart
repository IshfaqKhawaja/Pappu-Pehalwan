import 'package:flutter/foundation.dart';

class SaveChats with ChangeNotifier {
  Map<String, dynamic> savedChats = {
    'isChatPresent': false,
  };

  Map<String, dynamic> get getSavedChats {
    return savedChats;
  }

  void saveChats({saveChats = false, previousMessageFields, questionNumber, parentId, questions}) {
    savedChats['previousMessageFields'] = previousMessageFields;
    savedChats['questionNumber'] = questionNumber;
    savedChats['parentId'] = parentId;
    savedChats['isChatPresent'] = saveChats;
    savedChats['questions'] = questions;
    print(savedChats);
    notifyListeners();
  }
}
