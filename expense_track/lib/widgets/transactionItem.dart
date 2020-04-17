import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: EdgeInsets.all(6),
              child: FittedBox(
                  child: Text('\$${transaction.amount}')))),
      title: Text(
        transaction.title,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(
        DateFormat.yMMMd().format(transaction.date),
      ),
      trailing: MediaQuery.of(context).size.width > 460 ?
        FlatButton.icon(
          icon: Icon(Icons.delete),
          onPressed: () {
            deleteTransaction(transaction.id);
          },
          textColor: Theme.of(context).errorColor,
          label: Text("Delete"),
        )
        :
       IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          deleteTransaction(transaction.id);
        },
        color: Theme.of(context).errorColor,
      ),
    );
  }
}