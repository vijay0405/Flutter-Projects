import 'package:expense_track/models/transaction.dart';
import 'package:flutter/material.dart';
import './transactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Text("No Transactions added Yet!",
                  style: Theme.of(context).textTheme.title),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ],
          );
        }) 
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
            },
            itemCount: transactions.length);
  }
}

