import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx; // Function pointer

  const TransactionList(this.transactions, this.deleteTx, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text('\u20B9${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing:MediaQuery.of(context).size.width>460
                    ? TextButton.icon(
                      onPressed: () => deleteTx(
                        transactions[index].id,
                      ),
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).errorColor,
                      ),
                    )
                    :IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(
                        transactions[index].id,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
