import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function handleAddTransaction;

  NewTransaction({
    Key key,
    @required this.handleAddTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'title'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'amount'),
            ),
            FlatButton(
              onPressed: () => handleAddTransaction(
                  titleController.text, double.parse(amountController.text)),
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
