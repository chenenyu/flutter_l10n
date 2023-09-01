import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:submodule/generated/l10n.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter l10n',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        S.delegate,
        SubS.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Locale? _locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
    print(_locale?.toString());
  }

  void _changeLocale() async {
    var r = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                subtitle: const Text('en'),
                trailing: _locale?.languageCode == 'en'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  _locale = const Locale('en');
                  Navigator.pop(context, true);
                },
              ),
              ListTile(
                title: const Text('简体中文'),
                subtitle: const Text('zh'),
                trailing: _locale?.languageCode == 'zh'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  _locale = const Locale('zh');
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        );
      },
    );

    if (r == true) {
      print('changed to ${_locale?.toString()}');
      setState(() {}); // first trigger S.delegate.load(_locale)
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {}); // then trigger rebuild to update S.current
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: _locale,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Flutter l10n'),
          ),
          body: Center(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text('S.current.helloWorld'),
                  subtitle: Text(S.current.helloWorld),
                ),
                ListTile(
                  title: const Text('SubS.current.helloWorld'),
                  subtitle: Text(SubS.current.helloWorld),
                ),
                ListTile(
                  title: const Text("S.current.hello('Flutter')"),
                  subtitle: Text(S.current.hello('Flutter')),
                ),
                ListTile(
                  title: const Text("S.current.nPandas(0)"),
                  subtitle: Text(S.current.nPandas(0)),
                ),
                ListTile(
                  title: const Text("S.current.nPandas(1)"),
                  subtitle: Text(S.current.nPandas(1)),
                ),
                ListTile(
                  title: const Text("S.current.nPandas(2)"),
                  subtitle: Text(S.current.nPandas(2)),
                ),
                ListTile(
                  title: const Text("S.current.pronoun('male')"),
                  subtitle: Text(S.current.pronoun('male')),
                ),
                ListTile(
                  title: const Text("S.current.pronoun('female')"),
                  subtitle: Text(S.current.pronoun('female')),
                ),
                ListTile(
                  title: const Text("S.current.pronoun('other')"),
                  subtitle: Text(S.current.pronoun('other')),
                ),
                ListTile(
                  title: const Text("S.current.numberOfDataPoints(12345)"),
                  subtitle: Text(S.current.numberOfDataPoints(12345)),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _changeLocale();
            },
            child: const Icon(Icons.change_circle),
          )),
    );
  }
}
