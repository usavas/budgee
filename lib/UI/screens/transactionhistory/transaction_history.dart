import 'package:expenses/UI/helper/date_formatter.dart';
import 'package:expenses/UI/screens/account/current_month.dart';
import 'package:expenses/UI/screens/account/providers/current_month_year_provider.dart';
import 'package:expenses/UI/screens/transactionhistory/providers/transaction_history_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/transaction_info_dto.dart';
import '../../../models/helpers/double_helper.dart';
import 'package:expenses/models/transaction_info.dart';
import 'package:expenses/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  TransactionHistory({Key key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    var _paddingValue = MediaQuery.of(context).size.width * 0.02;
    return Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(_paddingValue),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Center(
                    child: Text("Advertisement here"),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.all(_paddingValue),
                    child: CurrentMonth(_paddingValue, _paddingValue))),
            ChangeNotifierProvider(
                create: (context) => TransactionHistoryProvider(),
                child: Expanded(flex: 5, child: TransactionInfoDtoList()))
          ],
        ));
  }
}

class TransactionInfoDtoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentMonthYearProvider monthProvider =
        Provider.of<CurrentMonthYearProvider>(context);
    var provider = Provider.of<TransactionHistoryProvider>(context);
    return FutureBuilder(
      future: provider.getTransactionInfoDtosByMonth(
          monthProvider.currentYear, monthProvider.currentMonth),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TransactionInfoDto> _transactions = snapshot.data;
          if (_transactions.length > 0) {
            return Scaffold(
              body: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return TransactionInfoDtoTile(_transactions[index]);
                },
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text('No transaction for this time period'),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                  'In TransactionInfoDtoList: ' + snapshot.error.toString()),
            ),
          );
        } else {
          print('Fetching the data...');
          return Scaffold(
            body: Center(
              child: Text('Fetching the data'),
            ),
          );
        }
      },
    );
  }
}

class TransactionInfoDtoTile extends StatelessWidget {
  final TransactionInfoDto transactionInfo;
  TransactionInfoDtoTile(this.transactionInfo);

  @override
  Widget build(BuildContext context) {
    CurrentMonthYearProvider monthProvider =
        Provider.of<CurrentMonthYearProvider>(context, listen: false);
    var provider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    return Card(
      // color: Color(transactionInfo.transactionTypeColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            IconData(transactionInfo.transactionTypeIcon,
                                fontFamily: 'MaterialIcons'),
                            color: Color(transactionInfo.transactionTypeColor),
                          ),
                          Padding(padding: EdgeInsets.all(4.0),),
                          Text(transactionInfo.transactionType),
                        ],
                      ),
                      Text(
                        getOnlyDateString(transactionInfo.transactionDate),
                        style: Theme.of(context).textTheme.body1.apply(
                            fontSizeFactor: 0.8, color: Colors.grey[600]),
                      ),
                      //? delete this widget below
                      Text(
                        transactionInfo.transactionDate.toIso8601String(),
                        style: Theme.of(context).textTheme.body1.apply(
                            fontSizeFactor: 0.8, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  (transactionInfo.transactionCategoryName == 'expense')
                      ? Text(
                          '-' +
                              DoubleHelper.convertDobleTo2DecimalPlaces(
                                  transactionInfo.transactionAmount),
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .apply(color: Colors.red.withAlpha(190)))
                      : Text(
                          DoubleHelper.convertDobleTo2DecimalPlaces(
                              transactionInfo.transactionAmount),
                        ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey[300],
                    ),
                    onPressed: () {
                      TransactionRepository()
                          .deleteTransaction(transactionInfo.transactionId)
                          .then((deletedId) {
                        provider.updateTransactionInfoDtosByMonth(
                            monthProvider.currentYear,
                            monthProvider.currentMonth);

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Transaction info deleted'),
                              FlatButton(
                                  child: Text('UNDO'),
                                  onPressed: () {
                                    TransactionRepository().insertTransaction(
                                        TransactionInfo.fromTransactionInfoDto(
                                            transactionInfo));
                                    provider.updateTransactionInfoDtosByMonth(
                                        monthProvider.currentYear,
                                        monthProvider.currentMonth);
                                  })
                            ],
                          ),
                        ));
                      });
                    },
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10)),
              if (transactionInfo.transactionNote != null &&
                  transactionInfo.transactionNote != '')
                Row(
                  children: <Widget>[
                    Text(
                      transactionInfo.transactionNote,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .apply(fontSizeFactor: 1.2, color: Colors.grey[700]),
                    ),
                  ],
                ),
            ],
          )),
    );
  }
}
