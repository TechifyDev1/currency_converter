import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class CurrencyConverterCupatinoPage extends StatefulWidget {
  const CurrencyConverterCupatinoPage({super.key});

  @override
  State<CurrencyConverterCupatinoPage> createState() =>
      _CurrencyConverterCupatinoPageState();
}

class _CurrencyConverterCupatinoPageState
    extends State<CurrencyConverterCupatinoPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  double exchangeRate = 0.00;
  double result = 0.00;
  Future<void> fetchExchangeRate() async {
    final String apiKey = dotenv.env['API_KEY'] ?? '';
    final url = Uri.parse(
      'https://open.er-api.com/v6/latest/USD?apikey=$apiKey',
    );

    try {
      final response = await get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('rates') && data['rates'].containsKey('NGN')) {
          setState(() {
            exchangeRate = data['rates']['NGN'];
          });
        } else {
          if (kDebugMode) {
            print("Invalid API response format");
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch exchange rate: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> convert() async {
    await fetchExchangeRate();
    setState(() {
      result =
          (double.parse(textEditingController.text) *
                  (exchangeRate > 0 ? exchangeRate : 1730))
              .roundToDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey3,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: const Text(
          "Currency Converter",
          style: TextStyle(color: Colors.white38),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NGN ${result.toString()}",
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.activeBlue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CupertinoTextField(
                style: const TextStyle(color: CupertinoColors.black),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 16, 3, 128),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                placeholder: "Enter the amount in USD",
                prefix: Icon(CupertinoIcons.money_dollar),
                controller: textEditingController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSubmitted: (value) {
                  result = double.parse(value);
                  if (kDebugMode) {
                    print("Value: $result");
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                convert();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text("Convert"),
            ),
          ],
        ),
      ),
    );
  }
}
