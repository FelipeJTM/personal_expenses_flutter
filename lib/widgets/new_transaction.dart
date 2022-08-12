import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  //DateTime _selectDate;

  DateTime _selectDate = DateTime.now();

  void _submitData() {
    final enteredTitleC = _titleController.text;
    final enteredAmountC = double.parse(_amountController.text);

    if (enteredTitleC.isEmpty || enteredAmountC <= 0) return;
    widget.addNewTransaction(
      enteredTitleC,
      enteredAmountC,
      _selectDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDayPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
    print("...");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          //  (_selectDate == null)
                          //      ? "No date selected"
                          //      : DateFormat.yMd().format(_selectDate),

                          "Date: ${DateFormat.yMd().format(_selectDate)}",
                          style: TextStyle()),
                    ),
                    TextButton(
                      onPressed: _presentDayPicker,
                      child: Text(
                        "choose date",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                /*  onChanged: (val) {
                            titleInput = val;
                          },*/
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
                /* onChanged: (val) {
                            amountInput = val;
                          },*/
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  _submitData();
                  // debugPrint("$titleInput, $amountInput");
                },
                child: Text("Add transaction",
                    style: TextStyle(
                      color: Colors.white,
                      // Theme.of(context).textTheme.button!.color,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
