import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hw_31_part_2_hive/pages/home_page.dart';
import 'package:hw_31_part_2_hive/services/hive_services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/result_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ResultModelAdapter());
  await Hive.openBox<ResultModel>('results');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:  HomePage()
    );
  }
}

