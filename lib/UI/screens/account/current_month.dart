import 'package:expenses/UI/helper/date_formatter.dart';
import 'package:expenses/UI/screens/account/providers/current_month_year_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentMonth extends StatelessWidget {
  const CurrentMonth(this.paddingWidth, this.paddingHeight, {Key key})
      : super(key: key);

  final paddingWidth;
  final paddingHeight;

  @override
  Widget build(BuildContext context) {
    CurrentMonthYearProvider monthProvider =
        Provider.of<CurrentMonthYearProvider>(context);

    return Container(
      child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(
              left: paddingWidth, right: paddingWidth, top: paddingHeight),
          child: Card(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Theme.of(context).textTheme.body1.color,
                      onPressed: () {
                        monthProvider.decreaseMonth();
                      },
                    ),
                    Text(getCurrMonthYear(DateTime(monthProvider.currentYear,
                        monthProvider.currentMonth))),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      color: Theme.of(context).textTheme.body1.color,
                      onPressed: () {
                        monthProvider.increaseMonth();
                      },
                    ),
                  ],
                )),
          )),
    );
  }
}
