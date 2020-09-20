import 'package:expenses/UI/helper/date_formatter.dart';
import 'package:expenses/UI/screens/providers/current_month_year_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentMonth extends StatelessWidget {
  const CurrentMonth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrentMonthYearProvider monthProvider =
        Provider.of<CurrentMonthYearProvider>(context);

    var _paddingWidth = MediaQuery.of(context).size.width * 0.03;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: _paddingWidth),
        child: Center(
          child: Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).textTheme.bodyText1.color,
                onPressed: () {
                  monthProvider.decreaseMonth();
                },
              ),
              Text(
                getCurrMonthYear(DateTime(
                    monthProvider.currentYear, monthProvider.currentMonth)),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                color: Theme.of(context).textTheme.bodyText1.color,
                onPressed: () {
                  monthProvider.increaseMonth();
                },
              ),
            ],
          )),
        ));
  }
}
