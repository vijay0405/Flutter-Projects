import 'package:expense_track/screens/authScreen.dart';
import 'package:expense_track/screens/settingsScreen.dart';
import 'package:expense_track/widgets/newTransaction.dart';
import 'package:expense_track/widgets/transactionList.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'widgets/transactionList.dart';
import 'package:flutter/material.dart';
import 'providers/transaction.dart';
import 'screens/splashScreen.dart';
import 'widgets/appDrawer.dart';
import 'providers/transactions.dart';
import 'providers/auth.dart';
import 'widgets/chart.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Expense());
}

class Expense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: Auth(),
      ),
      ChangeNotifierProvider.value(
        value: Transactions(),
      ),
    ]);

    child:
    Consumer<Auth>(
      builder: (ctx, auth, _) => MaterialApp(
        title: 'Track Expense',
        home: auth.isAuth
            ? MyHomePage()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) =>
                    authResultSnapshot.connectionState ==
                            ConnectionState.waiting
                        ? SplashScreen()
                        : AuthScreen()),
        routes: {SettingsScreen.routeName: (cts) => SettingsScreen()},
        theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.deepOrange,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  button: TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(fontFamily: 'OpenSans', fontSize: 20)))),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return (tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))));
    }).toList();
  }

  bool _showChart = false;

  // void _addNewTransaction(String title, double amount, DateTime chosenDate) {
  //   final newTx = Transaction(
  //       title: title,
  //       amount: amount,
  //       date: chosenDate,
  //       id: DateTime.now().toString());

  //   setState(() {
  //     transactions.add(newTx);
  //   });
  // }

  // void _deleteTransaction(String id) {
  //   setState(() {
  //     transactions.removeWhere((tx) {
  //       return tx.id == id;
  //     });
  //   });
  // }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(Transactions().addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget _buildLandscapeContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Show Chart"),
        Switch(
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        )
      ],
    );
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Track Expense"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(transactions, Transactions().deleteTransaction));
    final txChartWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            (isLandscape ? 0.7 : 0.3),
        child: Chart(_recentTransactions));
    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) _buildLandscapeContent(),
            if (!isLandscape) txChartWidget,
            if (!isLandscape) txListWidget,
            if (isLandscape) _showChart ? txChartWidget : txListWidget
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
