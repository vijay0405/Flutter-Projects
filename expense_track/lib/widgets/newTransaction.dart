import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now()).then((onValue){
          if(onValue == null ) {
            return;
          }

          setState(() {
            selectedDate = onValue;            
          });

        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
          child: Card(
          child: Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(selectedDate != null? DateFormat.yMMMd ().format(selectedDate): "No date chosen!"),
                  FlatButton(
                    child: Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitData,
              child: Text("Add Transaction"),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).accentColor,
            )
          ],
        ),
      )),
    );
  }
}
