import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  ExpenseChart(this.seriesList, {this.animate});

  factory ExpenseChart.withSampleData() {
    return new ExpenseChart(
      _createExpenseData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 40));
  }

  static List<charts.Series<TotalTransaction, String>> _createExpenseData() {
    final data = [
      new TotalTransaction("Yemek", 600, Colors.brown),
      new TotalTransaction("Kira", 1200, Colors.deepOrange),
      new TotalTransaction("Araba", 400, Colors.black38),
      new TotalTransaction("Hediye", 150, Colors.cyan),
    ];

    return [
      new charts.Series<TotalTransaction, String>(
        id: 'Expenses',
        domainFn: (TotalTransaction e, _) => e.type,
        measureFn: (TotalTransaction e, _) => e.totalAmount,
        colorFn: (TotalTransaction e, _) => charts.ColorUtil.fromDartColor(e.color),
        labelAccessorFn: (TotalTransaction row, _) => row.type,
        // labelAccessorFn: (TotalTransaction row, _) => '${row.type}',

        data: data,
      )
    ];
  }
}

class TotalTransaction {
  final String type;
  final double totalAmount;
  final Color color;

  TotalTransaction(this.type, this.totalAmount, this.color);
}