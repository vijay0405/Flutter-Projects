import 'package:expense_track/widgets/newTransaction.dart';
import 'package:expense_track/widgets/transactionList.dart';
import 'widgets/transactionList.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  runApp(Expense());
}

class Expense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track Expense',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(id: "t1", title: "shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t2", title: "groceries", amount: 9.99, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector( 
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
            );

        });
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Expense"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=>_startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: Container(width: double.infinity, child: Text("Chart")),
              elevation: 5,
            ),
            TransactionList(transactions)
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: ()=>_startAddNewTransaction(context), child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
