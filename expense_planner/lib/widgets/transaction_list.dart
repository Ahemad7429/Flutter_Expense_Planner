import 'package:expense_planner/models/models.dart';
import 'package:expense_planner/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList({
    Key key,
    @required this.transactions,
    @required this.deleteTx,
  }) : super(key: key);

  Widget _buildNoDataView(BuildContext ctx) {
    return LayoutBuilder(builder: (_, constrains) {
      return Column(
        children: [
          Text(
            'No transaction added yet!',
            style: Theme.of(ctx).textTheme.headline6,
          ),
          SizedBox(height: 10),
          Container(
            height: constrains.maxHeight * 0.7,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? _buildNoDataView(context)
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return TransactionItem(
                transaction: transactions[index],
                deleteTx: deleteTx,
              );
            },
          );
  }
}

// Card(
//                   child: Row(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 15,
//                           vertical: 10,
//                         ),
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             width: 2,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                         child: Text(
//                           '\$${transactions[index].amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             transactions[index].title,
//                             style: Theme.of(context).textTheme.headline6,
//                           ),
//                           Text(
//                             DateFormat.yMMMd().format(transactions[index].date),
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14.0,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
