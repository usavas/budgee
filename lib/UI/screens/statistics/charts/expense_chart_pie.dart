import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ExpenseChartPie extends StatelessWidget {
  ExpenseChartPie(this.dataMap, this.colorList);

  final Map<String, double> dataMap;
  final List<Color> colorList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 400),
        chartLegendSpacing: 32.0,
        chartRadius: MediaQuery.of(context).size.width / 2.4,
        showChartValuesInPercentage: true,
        showChartValues: true,
        showChartValuesOutside: true,
        chartValueBackgroundColor: Colors.grey[200],
        colorList: colorList,
        showLegends: true,
        legendPosition: LegendPosition.bottom,
        decimalPlaces: 2,
        showChartValueLabel: true,
        initialAngle: 0,
        chartValueStyle: defaultChartValueStyle.copyWith(
          color: Colors.blueGrey[900].withOpacity(0.9),
        ),
        chartType: ChartType.disc,
      )),
    );
  }
}
