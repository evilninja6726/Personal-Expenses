import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 465,
        child: (transactions.isEmpty)
            ? Column(
                children: [
                  Text('No Transactions Yet!!!'),
                  SizedBox(
                    height: 20,
                  ), //for 20 pixel gap b/w columns
                  Container(
                    //it is because for column as a parent it can take u to height as much and there is no height attibute
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  // return Card(
                  //   elevation: 10,
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             color: Theme.of(context).primaryColor,
                  //             width: 2,
                  //           ),
                  //         ),
                  //         margin: EdgeInsets.symmetric(
                  //           vertical: 10,
                  //           horizontal: 10,
                  //         ),
                  //         padding: EdgeInsets.all(10),
                  //         child: Text(
                  //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 20,
                  //               color: Theme.of(context).primaryColor),
                  //         ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             transactions[index].title,
                  //             // style: TextStyle(
                  //             //   fontSize: 18,
                  //             //   //fontFamily: 'GreatVibes',
                  //             //   color: Colors.black,
                  //             //   fontWeight: FontWeight.bold,
                  //             // ),
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .headline6, //refrencing the text style from our own theme for headline6 which is title
                  //           ),
                  //           Text(
                  //             DateFormat('dd-MM-yyyy')
                  //                 .format(transactions[index].dateTime),
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 color: Colors.grey,
                  //                 fontWeight: FontWeight.w500),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                        //this widget makes makes a row having a circle avtar, title and subtitle(behind title)
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: FittedBox(
                              child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}', //fix two decimal places
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          transactions[index].title,
                          // style: TextStyle(
                          //   fontFamily:
                          //       // Theme.of(context).textTheme.headline6.fontFamily),
                          //       'GreatVibes',
                          // ),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              DateFormat.yMMMd().format(transactions[index]
                                  .dateTime), //format the date in human readable format
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(DateFormat.jm()
                                .format(transactions[index].dateTime))
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        )),
                  );
                }));
  }
}
