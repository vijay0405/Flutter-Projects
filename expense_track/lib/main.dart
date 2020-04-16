import 'package:expense_track/transaction.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Expense());
}

class Expense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Expense Track", home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: "t1", title: "shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t2", title: "groceries", amount: 9.99, date: DateTime.now()),
  ];

  // String titleInput;
  // String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Track Expense")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Container(width: double.infinity, child: Text("Chart")),
            elevation: 5,
          ),
          Card(
              child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                ),
                FlatButton(
                  onPressed: () {
                    print(titleController.text);
                    print(amountController.text);
                  },
                  child: Text("Add Transaction"),
                  textColor: Colors.purple,
                )
              ],
            ),
          )),
          Column(
            children: transactions.map((tx) {
              return Card(
                  child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '\$${tx.amount}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tx.title.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.yMMMd().add_jm().format(tx.date),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ));
            }).toList(),
          )
        ],
      ),
    );
  }
}
