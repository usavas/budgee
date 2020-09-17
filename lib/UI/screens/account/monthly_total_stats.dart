import 'package:expenses/UI/screens/account/providers/current_month_year_provider.dart';
import 'package:expenses/UI/screens/account/providers/mothly_totals_provider.dart';
import 'package:expenses/models/monthly_total.dart';
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
          child:
              Consumer<MonthlyTotalsProvider>(builder: (context, provider, _) {
            return FutureBuilder<List<MonthlyTotalAmount>>(
                future: Future.wait([
                  provider.getMonthlyIncomeTotals(monthYearProvider.currentYear,
                      monthYearProvider.currentMonth),
                  provider.getMonthlyExpenseTotals(
                      monthYearProvider.currentYear,
                      monthYearProvider.currentMonth),
                ]),
                initialData: [
                  MonthlyTotalAmount(amount: 0),
                  MonthlyTotalAmount(amount: 0),
                ],
                builder: (context, snapshot) {
                  final Padding _padding =
                      Padding(padding: EdgeInsets.only(top: _paddingBtwTexts));

                  // if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                        child: Text(
                            'Add transactions to see the monthly statistics'));
                  }

                  return Container(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _padding,
                        AccountBalanceInfoRow(
                            'Income:',
                            snapshot.data[0].amount.toStringAsFixed(2),
                            Colors.green),
                        _padding,
                        AccountBalanceInfoRow(
                            'Expense:',
                            snapshot.data[1].amount.toStringAsFixed(2),
                            Colors.red),
                        _padding,
                        AccountBalanceInfoRow(
                            'Saved:',
                            (snapshot.data[0].amount - snapshot.data[1].amount)
                                .toStringAsFixed(2),
                            Colors.blue),
                        _padding,
                      ],
                    ),
                  );
                });
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
        Theme.of(context).textTheme.bodyText1.apply(fontSizeFactor: 1);

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
