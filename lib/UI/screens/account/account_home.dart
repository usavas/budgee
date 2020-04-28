import 'package:expenses/UI/screens/account/current_month.dart';
import 'package:expenses/UI/screens/account/providers/current_month_year_provider.dart';
import 'package:flutter/material.dart';

import 'package:expenses/models/transaction_type.dart';
import 'package:expenses/repositories/predefined_transaction_types_and_cats.dart'
    as p;
import 'package:provider/provider.dart';
import 'add_transaction.dart';
import 'monthly_total_stats.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var _paddingWidth = _size.width * 0.03;
    var _paddingHeight = _size.width * 0.02;

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => CurrentMonthYearProvider(),
        child: Column(children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
                margin: EdgeInsets.only(
                    left: _paddingWidth,
                    right: _paddingWidth,
                    top: _paddingHeight),
                decoration: BoxDecoration(border: Border.all()),
                child: Center(child: Text("Advertisement here"))),
          ),
          Expanded(
            flex: 2,
            child: CurrentMonth(_paddingWidth, _paddingHeight),
          ),
          Expanded(
            flex: 4,
            child: MonthlyTotalStats(_size),
          ),
          Expanded(
            flex: 10,
            child: Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              // color: Theme.of(context).backgroundColor,
              child: PageView(
                controller: PageController(initialPage: 0),
                children: <Widget>[
                  TransactionTypesPage(p.expenseTypes),
                  TransactionTypesPage(p.incomeTypes)
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

// Transaction types such as rent, utilities grouped under income and expense
//todo evaluate retrieving them from database
class TransactionTypesPage extends StatelessWidget {
  final List<TransactionType> transactionTypes;
  TransactionTypesPage(this.transactionTypes);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    double _spacingBtwTransactionTypes = _size.height <= 600 ? 0 : 8;

    List<TransactionTypeWidget> transactionTypesWidgets = new List();
    transactionTypes.forEach((type) => {
          transactionTypesWidgets.add(TransactionTypeWidget(
            transactionType: type,
          ))
        });

    return Container(
        margin: EdgeInsets.only(
            left: _size.width * 0.03,
            right: _size.width * 0.03,
            top: _size.width * 0.02,
            bottom: _size.width * 0.02),
        child: Card(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: _spacingBtwTransactionTypes,
                runSpacing: _spacingBtwTransactionTypes,
                children: <Widget>[
                  ...transactionTypesWidgets,
                ],
              ),
            ),
          ),
        ));
  }
}

class TransactionTypeWidget extends StatelessWidget {
  const TransactionTypeWidget({
    this.transactionType,
  });

  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    const Color _color = Colors.black87;

    var _size = MediaQuery.of(context).size;
    double _cardSize = _size.width * 0.20;
    double _fontSize;
    double _iconSize = 24;
    double _paddingTopIcon;

    if (_size.height <= 600) {
      _paddingTopIcon = 6.0;
    } else if (_size.height <= 1080) {
      _paddingTopIcon = 8.0;
    } else {
      _paddingTopIcon = 16.0;
    }

    if (_size.width <= 400) {
      _fontSize = 10;
      _iconSize = 20;
    } else if (_size.width < 720) {
      _fontSize = 12;
      _iconSize = 24;
    } else {
      _fontSize = 20;
      _iconSize = 32;
    }

    return Container(
      child: SizedBox(
        width: _cardSize,
        height: _cardSize,
        child: Card(
          color: Color(transactionType.transactionTypeColor),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTransaction(transactionType)));
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(_paddingTopIcon),
                    child: Icon(
                      transactionType.icon,
                      size: _iconSize,
                      color: _color,
                    ),
                    // ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(6, 4, 6, 0),
                    child: Text(
                      transactionType.transactionTypeName,
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(fontSize: _fontSize, color: _color),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
    // );
  }
}
