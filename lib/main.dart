import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shift_calendar/screens/loading_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '시프트 달력',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'title',
      ),
      home: LoadingPage(),
    );
  }
}
