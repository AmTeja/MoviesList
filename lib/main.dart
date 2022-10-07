import 'package:flutter/material.dart';
import 'package:movies_list/views/list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies List',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const ListScreen(),
    );
  }
}
