import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function txAdd;
  NewTransaction(this.txAdd);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate;

  void submit() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.txAdd(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: (selectedDate == null)
                          ? Text('No Date Choosen!')
                          : Text(
                              'Picked Date: ${DateFormat.yMMMEd().format(selectedDate)}',
                            ),
                    ),
                    TextButton(
                      onPressed: chooseDate,
                      child: Text(
                        'ChooseDate',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submit,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      color:
                          Theme.of(context).textTheme.button.backgroundColor),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
              ),
              // TextButton(
              //   onPressed: submit,
              //   child: Text(
              //     'Add Transaction',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold, color: Colors.purple),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
