import 'package:engineering_db/model/word_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifier/dictionary_notifier.dart';

class WordDetailScreen extends StatefulWidget {
  const WordDetailScreen({
    super.key,
    required this.wordModel,
    required this.index,
  });
  final WordModel wordModel;
  final int index;

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  @override
  Widget build(BuildContext context) {
    WordModel wordModel = widget.wordModel;
    TextTheme textTheme = TextTheme.of(context);

    DictionaryNotifier dictionaryNotifier =
        Provider.of<DictionaryNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(wordModel.eng),
        actions: [
          Consumer<DictionaryNotifier>(builder: (_, notifier, __) {
            int? fav = notifier.wordList[widget.index].favourite;
            return IconButton(
              onPressed: () {
                int updatedFav = fav == 1 ? 0 : 1;
                notifier.updateFavourite(
                  updatedFav,
                  wordModel.id,
                );
              },
              icon:
                  fav == 1 ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  wordModel.eng,
                  style: textTheme.titleLarge,
                ),
                Divider(),
                Text(
                  wordModel.type,
                  style: textTheme.bodyLarge,
                ),
                Divider(),
                Text(
                  wordModel.myan,
                  style: textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
