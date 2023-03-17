import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tipController = TextEditingController();
  double totalTip = 0.00;
  bool roundTipUp = false;

  int? currentRadio;
  var radioGroup = {
    0: "Amazing 20%",
    1: "Good 18%",
    2: "Okay 15%",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip time'),
        backgroundColor: Colors.green[400],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 14),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: TextField(
                controller: tipController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Service',
                ),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.room_service),
            title: Text("How was the service?"),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: radioGroupGenerator(),
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: Row(
              children: [
                const Text("Round up tip"),
                const Spacer(),
                Switch(
                  value: roundTipUp,
                  onChanged: (newvalue) {
                    setState(
                      () {
                        roundTipUp = newvalue;
                      },
                    );
                  },
                )
              ],
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.all(16),
            onPressed: () {
              totalTip = _tipCalculation();
              setState(() {});
            },
            color: Colors.green[400],
            child: const Text(
              'CALCULATE',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text(
            "Tip amount: \$${(totalTip).toStringAsFixed(2)}",
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  double _tipCalculation() {
    double? totalTip = double.tryParse(tipController.text);
    if (totalTip == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error to calculate tip'),
          content: const Text('Please enter your service total.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return 0.00;
    }

    double percent = 0.0;

    if (currentRadio == 0) {
      percent = 0.2;
    } else if (currentRadio == 1) {
      percent = 0.18;
    } else if (currentRadio == 2) {
      percent = 0.15;
    }

    totalTip = totalTip * percent;
    if (roundTipUp) {
      totalTip = totalTip.ceilToDouble();
    }

    return totalTip;
  }

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioElement) => ListTile(
            leading: Radio(
              value: radioElement.key,
              groupValue: currentRadio,
              onChanged: (int? selected) {
                currentRadio = selected;
                setState(() {});
              },
            ),
            title: Text(radioElement.value),
          ),
        )
        .toList();
  }
}
