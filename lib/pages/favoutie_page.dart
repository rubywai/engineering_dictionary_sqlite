import 'package:engineering_db/model/word_model.dart';
import 'package:engineering_db/notifier/dictionary_notifier.dart';
import 'package:engineering_db/widgets/word_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DictionaryNotifier>(context, listen: false).getFavWords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite List'),
      ),
      body: Consumer<DictionaryNotifier>(builder: (_, notifier, __) {
        List<WordModel> favList = notifier.favWordList;
        return WordListWidget(resultList: favList);
      }),
    );
  }
}
