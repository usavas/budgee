import 'charts/expense_chart_pie.dart';
import 'package:flutter/material.dart';

class AccountStats extends StatelessWidget {
  const AccountStats({Key key}) : super(key: key);

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

    return
     Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: 
      Container(
        color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(left: edgeinsets, right: edgeinsets),
          child: 
          ExpenseChartPie(
            dataMap, 
            colorList,
            )
          // ExpenseChart.withSampleData(),
          ),
    );
  }
}
