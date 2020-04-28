import 'package:flutter/material.dart';
import 'transaction.dart';

class Transactions with ChangeNotifier {
  List<Transaction> transactions;

  Transactions(this.transactions);

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());

    transactions.add(newTx);
    notifyListeners();
  }

  void _deleteTransaction(String id) {
    transactions.removeWhere((tx) {
      return tx.id == id;
    });
    notifyListeners();
  }
}
