import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:security_camera/Controllers/UrlHistoryController%20.dart';
import 'package:security_camera/Helpers/ConvertUrlPRovider.dart';
import 'package:security_camera/Models/url_history.dart';
import 'package:security_camera/Views/HomeScreen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  final controller = UrlHistoryController();

  try {
  final appDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDir.path);
  Hive.registerAdapter(UrlHistoryAdapter());
  await controller.init();
} catch (e) {
  print('Initialization error: $e');
}


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Converturlprovider()),
      ],
      child: MyApp(controller: controller),
    ),);
}

class MyApp extends StatelessWidget {
  final UrlHistoryController controller;
  
  const MyApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Shortener',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Homescreen(controller: controller),
    );
  }
}