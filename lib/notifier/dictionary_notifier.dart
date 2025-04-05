import 'package:engineering_db/db/db_service.dart';
import 'package:flutter/material.dart';
import '../model/word_model.dart';

class DictionaryNotifier extends ChangeNotifier {
  List<WordModel> wordList = [];
  List<WordModel> favWordList = [];
  String _keyword = "";
  DictionaryNotifier() {
    _initialWordView();
  }
  void _initialWordView() {
    DbService.initialWordList().then((value) {
      wordList = value;
      notifyListeners();
    });
  }

  void search(String keyword) async {
    _keyword = keyword;
    if (keyword.isEmpty) {
      _initialWordView();
    } else {
      wordList = await DbService.searchWord(keyword);
      notifyListeners();
    }
  }

  void updateFavourite(int fav, int id) async {
    await DbService.updateFavourite(fav, id);
    search(_keyword);
    getFavWords();
  }

  void getFavWords() async {
    favWordList = await DbService.getFavWords();
    notifyListeners();
  }
}
