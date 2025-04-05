import 'package:engineering_db/db/db_service.dart';
import 'package:engineering_db/model/word_model.dart';
import 'package:engineering_db/notifier/dictionary_notifier.dart';
import 'package:engineering_db/pages/favoutie_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/result_list_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DictionaryNotifier(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DictionaryNotifier dbNotifier =
        Provider.of<DictionaryNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Engineering Dictionary"),
        actions: [
          IconButton(
            tooltip: 'Favourite Page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavouritePage(),
                ),
              );
            },
            icon: Icon(Icons.favorite),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (String? text) {
                setState(() {});
                dbNotifier.search(text ?? '');
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search Engineering word(English)',
                enabledBorder: OutlineInputBorder(),
                suffixIcon: (_controller.text.trim().isNotEmpty)
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                          });
                        },
                        icon: Icon(Icons.clear),
                      )
                    : SizedBox.shrink(),
              ),
            ),
            Expanded(
              child: ResultList(),
            ),
          ],
        ),
      ),
    );
  }
}
