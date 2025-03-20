import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'currency_converter_material_page.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

//1. matenial design
//2. cupertino design

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CurrencyConverterPagee());
  }
}
