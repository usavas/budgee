import 'package:expenses/UI/screens/account/current_month.dart';
import 'package:expenses/models/monthly_transaction_types_totals.dart';
import 'package:expenses/repositories/monthly_transaction_types_totals_repository.dart';
import 'package:provider/provider.dart';
import 'charts/expense_chart_pie.dart';
import 'package:flutter/material.dart';

import 'providers/current_month_year_provider.dart';

class MonthlyTotalStatsDetailed extends StatelessWidget {
  const MonthlyTotalStatsDetailed({Key key}) : super(key: key);

//todo show monthly totals of transactions categorized under each transaction type
  @override
  Widget build(BuildContext context) {
    final double edgeinsets = MediaQuery.of(context).size.width * 0.2;

    // Map<String, double> dataMap = Map();
    // dataMap.putIfAbsent("Yemek", () => 400);
    // dataMap.putIfAbsent("Kira", () => 1200);
    // dataMap.putIfAbsent("Benzin", () => 600);
    // dataMap.putIfAbsent("Hediye", () => 150);

    // List<Color> colorList = [
    //   Colors.red,
    //   Colors.green,
    //   Colors.blue,
    //   Colors.yellow,
    // ];

    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CurrentMonth(16.0, 16.0),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  Consumer<CurrentMonthYearProvider>(
                    builder: (context, monthProvider, _) {
                      return FutureBuilder<List<MonthlyTransactionTypesTotal>>(
                          future: MonthlyTransactionTypesTotalsRepository()
                              .getMonthlyExpenseTransactionTypesTotals(
                                  monthProvider.currentYear,
                                  monthProvider.currentMonth),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(
                                  'monthly transaction type total stats: error occured');
                              print(snapshot.error);
                              return Center(
                                child: Text(
                                    'monthly transaction type total stats: error occured'),
                              );
                            } else if (snapshot.hasData) {
                              return (snapshot.data != null &&
                                      snapshot.data.length > 0)
                                  ? Container(
                                      color: Theme.of(context).backgroundColor,
                                      padding: EdgeInsets.only(
                                          left: edgeinsets, right: edgeinsets),
                                      child: ExpenseChartPie(
                                        _getDataMapFromTransactionTypeTotals(
                                            snapshot.data),
                                        // todo retrieve the colors of each items
                                        [
                                          Colors.red,
                                          Colors.green,
                                          Colors.blue,
                                          Colors.yellow,
                                        ],
                                      )
                                      // ExpenseChart.withSampleData(),
                                      )
                                  : Text('No transaction info for this month');
                            } else {
                              return Center(
                                child: Text('There is no data for this month'),
                              );
                            }
                          });
                    },
                  ),
                ])));
  }

  Map<String, double> _getDataMapFromTransactionTypeTotals(
      List<MonthlyTransactionTypesTotal> transactionTypesTotals) {
    Map<String, double> maps = Map<String, double>();
    for (var t in transactionTypesTotals) {
      maps.putIfAbsent(t.transactionTypeName, () => t.totalAmount);
    }
    return maps;
  }
}
