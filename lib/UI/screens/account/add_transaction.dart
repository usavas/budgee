import 'dart:developer';
import 'package:expenses/UI/helper/date_formatter.dart';
import 'package:expenses/dao/transaction_info_dao.dart';
import 'package:expenses/models/transaction_info.dart';
import 'package:expenses/models/transaction_type.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction(this.transactionType, {Key key}) : super(key: key);

  final TransactionType transactionType;

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().add(new Duration(days: -365)),
      lastDate: DateTime.now().add(new Duration(days: 61)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            accentColor: const Color(0xFF4A5BF6), //selection color
            textTheme: Theme.of(context).textTheme,
            dialogBackgroundColor:
                Theme.of(context).backgroundColor, //Background color
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    final Padding _padding = Padding(
      padding: EdgeInsets.only(top: 0),
    );


    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            getOnlyDateString(selectedDate).toString(),
                            textAlign: TextAlign.start,
                          ),
                          FlatButton(
                            child: Text("Select a Date"),
                            onPressed: () => _selectDate(context),
                          )
                        ],
                      ),
                      _padding,
                      TextFormField(
                        style: Theme.of(context).textTheme.body1,
                        autofocus: true,
                        controller: _amountController,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        maxLength: 10,
                        decoration: const InputDecoration(
                          labelText: 'Enter an amount',
                        ),
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter the amount of transaction';
                          } else if (!isNumeric(value.trim())) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                      ),
                      _padding,
                      TextFormField(
                        style: Theme.of(context).textTheme.body1,
                        controller: _noteController,
                        maxLines: 2,
                        maxLength: 64,
                        decoration: const InputDecoration(
                          labelText: 'Notes (Optional)',
                        ),
                      ),
                      _padding,
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                TransactionDao()
                                    .insertTransaction(TransactionInfo(
                                  transactionNote: _noteController.text,
                                  transactionAmount:
                                      double.parse(_amountController.text),
                                  transactionDate: selectedDate,
                                  transactionTypeId: widget.transactionType.transactionTypeId,
                                ))
                                    .then((insertedId) {
                                  log("inserted: " + insertedId.toString());
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Add Transaction',
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
