import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

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

  bool _showChart = false;

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

  List<Widget> _buildLandScapeContent(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top -
                      mediaQuery.padding.bottom) *
                  0.7,
              child: Chart(
                recentTransaction: _recentTransactions,
              ),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPotraitContent(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
    Widget txListWidget,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top -
                mediaQuery.padding.bottom) *
            0.3,
        child: Chart(
          recentTransaction: _recentTransactions,
        ),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    bool _isLandScapeModel = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Planner'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    return _startAddNewTransaction(context);
                  },
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expense Planner'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  return _startAddNewTransaction(context);
                },
              )
            ],
          );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              _appBar.preferredSize.height -
              mediaQuery.padding.top -
              mediaQuery.padding.bottom) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTx: _deleteTransaction,
      ),
    );

    final _body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandScapeModel)
              ..._buildLandScapeContent(mediaQuery, _appBar, txListWidget),
            if (!_isLandScapeModel)
              ..._buildPotraitContent(mediaQuery, _appBar, txListWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _body,
            navigationBar: _appBar,
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? SizedBox.shrink()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      return _startAddNewTransaction(context);
                    },
                  ),
            appBar: _appBar,
            body: _body,
          );
  }
}
