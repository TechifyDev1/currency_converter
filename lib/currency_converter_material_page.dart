import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrencyConverterPagee extends StatefulWidget {
  const CurrencyConverterPagee({super.key});
  @override
  State<CurrencyConverterPagee> createState() =>
      _CurrencyCoverterStatePageState();
}

class _CurrencyCoverterStatePageState extends State<CurrencyConverterPagee> {
  final TextEditingController textEditingController = TextEditingController();
  void convert() {
    setState(() {
      result =
          (double.parse(textEditingController.text) * 1535.17).roundToDouble();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  double result = 0.00;
  @override
  Widget build(BuildContext context) {
    print("rebuild");
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(40)),
    );
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          "Currency Converter",
          style: TextStyle(color: Colors.white38),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NGN ${result.toString()}",
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter amount in USD",
                  hintStyle: const TextStyle(color: Colors.white60),
                  prefixIcon: const Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.white12,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
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
            TextButton(
              onPressed: convert,
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
