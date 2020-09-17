import 'dart:developer';
import 'package:expenses/UI/helper/date_formatter.dart';
import 'package:expenses/UI/screens/account/providers/mothly_totals_provider.dart';
import 'package:expenses/models/transaction_info.dart';
import 'package:expenses/models/transaction_type.dart';
import 'package:expenses/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      firstDate: DateTime.now().add(new Duration(days: -61)),
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
        //? Adding some hours (apparently equal or greater than 9) is required to include the first day of month in the month-group
        selectedDate = picked.add(Duration(hours: 12, minutes: 30));
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
      padding: EdgeInsets.only(top: 12),
    );

    MonthlyTotalsProvider _monthlyTotalProvider =
        Provider.of<MonthlyTotalsProvider>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text(
                              getOnlyDateString(selectedDate).toString(),
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: FlatButton(
                                child: Center(child: Text("Select a Date")),
                                onPressed: () => _selectDate(context),
                              )),
                        ],
                      ),
                      _padding,
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        autofocus: true,
                        controller: _amountController,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        maxLength: 10,
                        decoration: const InputDecoration(
                          hintText: 'Enter an amount',
                          // labelText: 'Enter an amount',
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
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: _noteController,
                        maxLines: 2,
                        maxLength: 64,
                        decoration: const InputDecoration(
                          hintText: 'Notes (Optional)',
                          // labelText: 'Notes (Optional)',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              // to dismiss the keyboard
                              FocusScope.of(context).unfocus();
                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  TransactionRepository()
                                      .insertTransaction(TransactionInfo(
                                    transactionNote: _noteController.text,
                                    transactionAmount:
                                        double.parse(_amountController.text),
                                    transactionDate: selectedDate,
                                    transactionTypeId: widget
                                        .transactionType.transactionTypeId,
                                  ))
                                      .then((insertedId) {
                                    log("inserted: " + insertedId.toString());
                                    //todo update the monthlytotals
                                    _monthlyTotalProvider
                                        .notifyListernersCustom();
                                  });
                                  // to dismiss the keyboard
                                  FocusScope.of(context).unfocus();
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                'Add Transaction',
                              ),
                            ),
                          ),
                        ],
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
