import 'package:engineering_db/pages/word_detail_screen.dart';
import 'package:engineering_db/widgets/word_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/word_model.dart';
import '../notifier/dictionary_notifier.dart';

class ResultList extends StatelessWidget {
  const ResultList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DictionaryNotifier>(
      builder: (context, notifier, _) {
        List<WordModel> resultList = notifier.wordList;
        return WordListWidget(resultList: resultList);
      },
    );
  }
}
