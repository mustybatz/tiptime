import 'package:flutter/material.dart';

class FormModel extends ChangeNotifier {
  int billAmount;
  double tipPercent;
  bool roundTotal;
  double tipAmount;

  FormModel({
    this.billAmount = 0,
    this.tipPercent = 0.15,
    this.roundTotal = false,
    this.tipAmount = 0.0,
  });

  void calculateTip() {
    tipAmount = billAmount * tipPercent;
    if (roundTotal) {
      tipAmount = tipAmount.ceilToDouble();
    }
    notifyListeners();
  }
}
