import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction>
      recentTransactionList; //to get the list of transactions
  Chart(this.recentTransactionList);
  List<Map<String, Object>> get getTransactionValues {
    // we will map the day label with amount in last 7 days
    return List.generate(7, (index) {
      //generate a list eventually our bars
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      ); //for 0 index it will subtract 0 days which is today for 1 it subtract 1 which is yesterday
      double totalSum = 0.0;

      for (int i = 0; i < recentTransactionList.length; i++) {
        //sum all the transaction amount in the total sum to get last lenth sum
        if (recentTransactionList[i].dateTime.day ==
                weekDay.day && // for checking the same day
            recentTransactionList[i].dateTime.month ==
                weekDay.month && // for checking the same month
            recentTransactionList[i].dateTime.year == weekDay.year) {
          // for checking the same year
          totalSum += recentTransactionList[i].amount;
          // sum up all the transaction in transaction list
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get amountPercentage {
    return getTransactionValues.fold(0.0, (sum, element) {
      //getter to get the amount percentage and fold is the method which
      // returns a sinlge value from a previous value by summing up all the values present in the list
      return sum +=
          element['amount']; //we will return the sum up value to this getter
    });
  }

  @override
  Widget build(BuildContext context) {
    print(getTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // children: [
          //   Column(
          //     children: [
          //       Text('Dollar'),
          //       Container(
          //         child: Text('Bar'),
          //       ),
          //       Text('Label'),
          //     ],
          //   )
          // ],
          children: getTransactionValues.map((e) {
            // return Text(
            //   '${e['day']}:\$${e['amount'].toString().substring(0, 1)}',
            // );
            return Flexible(
              //we can use expanded also which takes a flex arguemt and works same as above
              // fit: FlexFit.loose fits the text in the box in a given free space
              fit: FlexFit
                  .tight, // fit the text in the box in a single line in a given free space
              child: ChartBar(
                  e['day'],
                  e['amount'],
                  amountPercentage ==
                          0 //if amount is zero we return zero percentage jist to avoid divide by zero exception
                      ? 0.0
                      : (e['amount'] as double) /
                          amountPercentage), //amount percentage is that day amount which is added by total sum already present on that day
            );
          }).toList(),
        ),
      ),
    );
  }
}
