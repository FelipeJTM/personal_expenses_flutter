import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import 'models/transactions.dart';

//
void main() {
  runApp(MyApp());
}

//
class MyApp extends StatefulWidget {
  //late String titleInput;
  //late String amountInput;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
                button: TextStyle(color: Colors.white),
              ),
        ),
        //accentColor: Colors.amberAccent
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _userTransactions = [
    /* Transactions(
      id: "1",
      title: "cosa1",
      amount: 20.2,
      date: DateTime.now(),
    ),
    Transactions(
      id: "2",
      title: "cosa2",
      amount: 23.2,
      date: DateTime.now(),
    ),*/
  ];

  //se quiere filtrar de todas las transacciones solo las que ocurrieron la
  //ultima semana...
  List<Transactions> get _recentTransactions {
    //obtener las ultimas transacciones
    return _userTransactions.where((tx) {
      //retorna las transacciones del usuario donde ...
      return tx.date.isAfter(
        //la fecha de la transaccion...
        DateTime.now().subtract(
          //la fecha actual
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _addNewTransaction(String txTitle, double amount, DateTime chosenDate) {
    final newTx = Transactions(
      title: txTitle,
      amount: amount,
      //date: DateTime.now(),
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    debugPrint("que pedp");
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          //return NewTransaction(_addNewTransaction);
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Expenses",
          style: TextStyle(
            fontFamily: 'OpenSans',
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
            TransactionList(_deleteTransaction,
                userTransactions: _userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
