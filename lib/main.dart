import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
// import './widgets/transaction_list.dart';

import './models/Transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //fontFamily: 'GreatVibes', // setting the font for everything
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                //fontFamily: 'GreatVibes',
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          //set appbar theme
          textTheme: ThemeData.light().textTheme.copyWith(
              //themedata.light is default theme and we set its texttheme with own customized using copywith
              headline6: TextStyle(
                //headline6 is same as title
                //fontFamily: 'GreatVibes',
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white)),
        ),
        // used for colors and texts for all the components in the widget tree
        primaryColor: Colors.purple, // main color
        // accentColor: Colors.amber, // alternative color
        buttonColor: Colors.purple,
        errorColor: Colors.red,
      ),
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1',
    //     title: 'Pomegranate',
    //     amount: 25.76,
    //     dateTime: DateTime.now()),
    // Transaction(
    //   id: 't2',
    //   title: 'Mango Juice',
    //   amount: 45.55,
    //   dateTime: DateTime.now(),
    // )
  ];

  List<Transaction> get recentTransactionList {
    return _userTransactions.where((element) {
      return element.dateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime choosedDate) {
    final Transaction txNew = new Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      dateTime: choosedDate,
    );

    setState(() {
      _userTransactions.add(txNew);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (builderContext) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).primaryColor, //manually set red color
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //   Container(
              //     width: double.infinity,
              //     child: Card(
              //       color: Colors.blue,
              //       elevation: 10,
              //       child: Text('Chart'),
              //     ),
              //   ),
              //   TransactionList(_userTransactions),
              // ],
              Chart(recentTransactionList),
              TransactionList(_userTransactions, deleteTransaction),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
