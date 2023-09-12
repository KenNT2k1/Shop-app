import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _locale = const Locale('en');
                        });
                      },
                      child: const Text('En')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _locale = const Locale('es');
                        });
                      },
                      child: const Text('Es')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _locale = const Locale('vi');
                        });
                      },
                      child: const Text('Vi')),
                ],
              ),
              const MyHomePage(),
              const AssetImages(),
              const CustomFonts(),
              const _GoogleFonts(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleFonts extends StatefulWidget {
  const _GoogleFonts();

  @override
  State<_GoogleFonts> createState() => _GoogleFontsState();
}

class _GoogleFontsState extends State<_GoogleFonts> {
  late Future googleFontsPending;
  @override
  void initState() {
    googleFontsPending = GoogleFonts.pendingFonts([
      GoogleFonts.poppins(),
      GoogleFonts.montserrat(fontStyle: FontStyle.italic),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pushButtonTextStyle = GoogleFonts.poppins(
      textStyle: Theme.of(context).textTheme.headlineMedium,
    );
    final counterTextStyle = GoogleFonts.montserrat(
      fontStyle: FontStyle.italic,
      textStyle: Theme.of(context).textTheme.displayLarge,
    );

    return Column(
      children: [
        Text(
          'You have pushed the button this many times:',
          style: pushButtonTextStyle,
        ),
        Text('Hello word', style: counterTextStyle),
      ],
    );
  }
}

class CustomFonts extends StatelessWidget {
  const CustomFonts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Pod installation complete! There are 3 dependencies from the Podfile and 3 total pods installed.',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Pod installation complete! There are 3 dependencies from the Podfile and 3 total pods installed.',
          style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Reloaded 1 of 1094 libraries in 186ms '),
        ElevatedButton(onPressed: () {}, child: const Text('Reloaded 1'))
      ],
    );
  }
}

class AssetImages extends StatelessWidget {
  const AssetImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Stack(
          children: [
            Image(
              image: AssetImage(
                'assets/images/shopping_bags_background.jpg',
              ),
              height: 200,
              width: 400,
            ),
            Image(image: AssetImage('assets/icons/ic_heart.png')),
          ],
        ),
        SvgPicture.asset(
          'assets/vectors/red_bird.svg',
          semanticsLabel: 'Acme Logo',
        ),
        SvgPicture.network(
            'https://raw.githubusercontent.com/dnfield/flutter_svg/7d374d7107561cbd906d7c0ca26fef02cc01e7c8/example/assets/flutter_logo.svg?sanitize=true')
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // The [AppBar] title text should update its message
        // according to the system locale of the target platform.
        // Switching between English and Spanish locales should
        // cause this text to update.
        Text(AppLocalizations.of(context)!.helloWorld),
        // Add the following code
        Localizations.override(
          context: context,
          locale: const Locale('en'),
          // Using a Builder here to get the correct BuildContext.
          // Alternatively, you can create a new widget and Localizations.override
          // will pass the updated BuildContext to the new widget.
          child: Builder(
            builder: (context) {
              // #docregion Placeholder
              // Examples of internationalized strings.
              return Column(
                children: <Widget>[
                  // Returns 'Hello John'
                  Text(AppLocalizations.of(context)!.hello('John')),
                  // Returns 'no wombats'
                  Text(AppLocalizations.of(context)!.nWombats(0)),
                  // Returns '1 wombat'
                  Text(AppLocalizations.of(context)!.nWombats(1)),
                  // Returns '5 wombats'
                  Text(AppLocalizations.of(context)!.nWombats(5)),
                  // Returns 'he'
                  Text(AppLocalizations.of(context)!.pronoun('male')),
                  // Returns 'she'
                  Text(AppLocalizations.of(context)!.pronoun('female')),
                  // Returns 'they'
                  Text(AppLocalizations.of(context)!.pronoun('other')),
                ],
              );
              // #enddocregion Placeholder
            },
          ),
        ),
      ],
    );
  }
}
