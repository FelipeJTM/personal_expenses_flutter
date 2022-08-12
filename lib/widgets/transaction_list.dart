import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';

//here is everything where is showed above the card with the expenses of the week

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;
  final Function deleteTx;

  const TransactionList(this.deleteTx,
      {Key? key, required this.userTransactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10,bottom:(MediaQuery.of(context).size.height/8)),
      height: MediaQuery.of(context).size.height,
      //child: ListView(
      child: (userTransactions.isEmpty)
          ? Column(
              children: [
                Text(
                  "No transactions yet",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ttx, index) {
                return myListTile(index, userTransactions, context, deleteTx);
              },
              itemCount: userTransactions.length,
              //code above only works with columns and listView
              /*       children: userTransactions.map((tx) {
        }).toList(),*/
            ),
    );
  }
}

Card myFirstOption(
    int index, BuildContext context, List<Transactions> userTransactions) {
  return Card(
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            "\$${userTransactions[index].amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userTransactions[index].title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              // "${tx.date.year} - ${tx.date.month}  - ${tx.date.day}",
              DateFormat().format(userTransactions[index].date),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

//Diferent Option to show the content
Card myListTile(int index, List<Transactions> transactions,
    BuildContext context, Function delete) {
  return Card(
    elevation: 5,
    margin: EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 5,
    ),
    child: ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(
            child: Text('\$${transactions[index].amount}'),
          ),
        ),
      ),
      title: Text(
        transactions[index].title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        DateFormat.yMMMd().format(transactions[index].date),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        color: Theme.of(context).errorColor,
        onPressed: () => delete(transactions[index].id),
      ),
    ),
  );
}
