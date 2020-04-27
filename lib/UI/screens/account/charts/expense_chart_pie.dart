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
          showChartValuesInPercentage: false,
          showChartValues: true,
          showChartValuesOutside: false,
          chartValueBackgroundColor: Colors.grey[200],
          colorList: colorList,
          showLegends: true,
          legendPosition: LegendPosition.bottom,
          decimalPlaces: 1,
          showChartValueLabel: true,
          initialAngle: 0,
          chartValueStyle: defaultChartValueStyle.copyWith(
            color: Colors.blueGrey[900].withOpacity(0.9),
          ),
          chartType: ChartType.ring,
        )),
    );
  }
}



  // Map<String, double> dataMap = Map();
  // List<Color> colorList = [
  //   Colors.red,
  //   Colors.green,
  //   Colors.blue,
  //   Colors.yellow,
  // ];

  // @override
  // void initState() {
  //   super.initState();
  //   dataMap.putIfAbsent("Yemek", () => 400);
  //   dataMap.putIfAbsent("Kira", () => 1200);
  //   dataMap.putIfAbsent("Benzin", () => 600);
  //   dataMap.putIfAbsent("Hediye", () => 150);
  // }