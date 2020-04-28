import 'package:expenses/UI/helper/date_formatter.dart';
import 'package:expenses/UI/screens/account/providers/current_month_year_provider.dart';
import 'package:provider/provider.dart';

import 'charts/expense_chart.dart';
import 'charts/expense_chart_pie.dart';
import 'package:flutter/material.dart';

class MonthlyTotalStatsDetailed extends StatelessWidget {
  const MonthlyTotalStatsDetailed(this.year, this.month, {Key key}) : super(key: key);

  final int year;
  final int month;

//todo show monthly totals of transactions categorized under each transaction type
  @override
  Widget build(BuildContext context) {
    final double edgeinsets = MediaQuery.of(context).size.width * 0.2;

    Map<String, double> dataMap = Map();
    dataMap.putIfAbsent("Yemek", () => 400);
    dataMap.putIfAbsent("Kira", () => 1200);
    dataMap.putIfAbsent("Benzin", () => 600);
    dataMap.putIfAbsent("Hediye", () => 150);

    List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder(
          // future:
          builder: (context, snapshot) {
            return Container(
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.only(left: edgeinsets, right: edgeinsets),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(getCurrMonthYear(DateTime(year, month))),
                    Padding(
                      padding: EdgeInsets.all(16),
                    ),
                    ExpenseChartPie(
                      dataMap,
                      colorList,
                    ),
                  ],
                )
                // ExpenseChart.withSampleData(),
                );
          },
        ),
      ),
    );
  }
}
