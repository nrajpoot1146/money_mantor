
import 'package:flutter/material.dart';
import 'package:money_mantor/di/locator.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/views/screens/home_screen.dart';
import 'di/configure_dependencies.dart';
import 'utils/theme/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool _isReady = true;
  @override
  void initState() {
    super.initState();
    Global.init().then(
      (value) => {
        setState(
          () {
            _isReady = true;
          },
        ),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reassemble() {
    // Global.init().then(
    //   (value) => {_isReady = true},
    // );
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: MaterialTheme.lightScheme(),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: MaterialTheme.darkScheme(),
        useMaterial3: true
      ),
      themeMode: ThemeMode.dark,
      home:
          !_isReady ? const Text("Loading Config") : const HomeScreen(),
    );
  }
}
