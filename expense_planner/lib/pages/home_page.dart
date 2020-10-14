import 'package:expense_planner/models/models.dart';
import 'package:expense_planner/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
    /* Transaction(
        id: 't1', title: 'New Clothes', amount: 79.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Home Gloceries', amount: 19.79, date: DateTime.now()), */
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
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

  void _addNewTransaction(String txTitle, double txAmount, DateTime choseDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: choseDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(handleAddTransaction: _addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          return _startAddNewTransaction(context);
        },
      ),
      appBar: AppBar(
        title: Text(
          'Expense Planner',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              return _startAddNewTransaction(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(
              recentTransaction: _recentTransactions,
            ),
            TransactionList(
              transactions: _userTransactions,
              deleteTx: _deleteTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
