import 'package:expenses/UI/screens/account/providers/current_month_year_provider.dart';
import 'package:expenses/models/monthly_total.dart';
import 'package:expenses/repositories/monthly_totals_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'monthly_transaction_type_totals.dart';

class MonthlyTotalStats extends StatefulWidget {
  MonthlyTotalStats({Key key}) : super(key: key);

  @override
  _MonthlyTotalStatsState createState() => _MonthlyTotalStatsState();
}

class _MonthlyTotalStatsState extends State<MonthlyTotalStats> {
  @override
  Widget build(BuildContext context) {
    var _paddingWidth = MediaQuery.of(context).size.width * 0.03;
    // var _paddingHeight = MediaQuery.of(context).size.width * 0.01;

    double _paddingBtwTexts = MediaQuery.of(context).size.height <= 600 ? 4 : 6;
    double _paddingAboveContent =
        MediaQuery.of(context).size.height <= 500 ? 2 : 4;
    double _paddingAroundLeftRight =
        MediaQuery.of(context).size.height <= 500 ? 12 : 18;

    CurrentMonthYearProvider monthYearProvider =
        Provider.of<CurrentMonthYearProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MonthlyTotalStatsDetailed()));
      },
      child: Container(
        padding: EdgeInsets.only(left: _paddingWidth, right: _paddingWidth),
        child: Card(
            child: Container(
          padding: EdgeInsets.only(
              left: _paddingAroundLeftRight,
              right: _paddingAroundLeftRight,
              top: _paddingAboveContent),
          alignment: Alignment.centerLeft,
          child: FutureBuilder<List<MonthlyTotalAmount>>(
              future: Future.wait([
                MonthlyTotalAmountsRepository()
                    .getMonthlyIncomeTransactionTotal(
                        monthYearProvider.currentYear,
                        monthYearProvider.currentMonth),
                MonthlyTotalAmountsRepository()
                    .getMonthlyExpenseTransactionTotal(
                        monthYearProvider.currentYear,
                        monthYearProvider.currentMonth),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // this returns an empty list from respected dao, check if the list empty, and only then show this text
                    print(snapshot.error);
                    return Center(
                        child: Text(
                            'Add transactions to see the monthly statistics'));
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: _paddingBtwTexts)),
                      AccountBalanceInfoRow(
                          'Income:',
                          snapshot.data[0].amount.toStringAsFixed(2),
                          Colors.green),
                      Padding(padding: EdgeInsets.only(top: _paddingBtwTexts)),
                      AccountBalanceInfoRow(
                          'Expense:',
                          snapshot.data[1].amount.toStringAsFixed(2),
                          Colors.red),
                      Padding(padding: EdgeInsets.only(top: _paddingBtwTexts)),
                      AccountBalanceInfoRow(
                          'Saved:',
                          (snapshot.data[0].amount - snapshot.data[1].amount)
                              .toStringAsFixed(2),
                          Colors.blue),
                    ],
                  );
                } else {
                  return Center(

                      // child: Text('Fetching statistics'),

                      );
                }
              }),
        )),
      ),
    );
  }
}

class AccountBalanceInfoRow extends StatelessWidget {
  final String text1;
  final String text2;
  final Color color;

  AccountBalanceInfoRow(this.text1, this.text2, this.color);
  @override
  Widget build(BuildContext context) {
    final TextStyle _textStyleSm =
        Theme.of(context).textTheme.body1.apply(fontSizeFactor: 1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  width: 16,
                  height: 16,
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Text(text1, style: _textStyleSm),
              ],
            ),
          ],
        ),
        Text(text2, style: _textStyleSm)
      ],
    );
  }
}

class Placeholder extends StatelessWidget {
  Placeholder({Key key, this.paddingBtwTexts}) : super(key: key);

  final double paddingBtwTexts;

  final BoxDecoration _decoration =
      BoxDecoration(borderRadius: BorderRadius.circular(10));
  final double _alpha = 0.2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: paddingBtwTexts)),
          Expanded(
            child: Container(
              decoration:
                  _decoration.copyWith(color: Colors.green.withOpacity(_alpha)),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: paddingBtwTexts)),
          Expanded(
            child: Container(
              decoration:
                  _decoration.copyWith(color: Colors.red.withOpacity(_alpha)),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: paddingBtwTexts)),
          Expanded(
            child: Container(
              decoration:
                  _decoration.copyWith(color: Colors.blue.withOpacity(_alpha)),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: paddingBtwTexts)),
        ],
      ),
    );
  }
}
