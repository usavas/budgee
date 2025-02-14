import 'package:auto_size_text/auto_size_text.dart';
import 'package:expenses/UI/helper/date_formatter.dart';
import 'package:expenses/UI/screens/widgets/current_month_view.dart';
import 'package:expenses/UI/screens/widgets/monthly_summary_view.dart';
import 'package:expenses/UI/screens/providers/current_month_year_provider.dart';
import 'package:expenses/UI/screens/transactionhistory/providers/transaction_history_provider.dart';
import 'package:expenses/UI/screens/widgets/advertisement_view.dart';
import 'package:provider/provider.dart';
import '../../../models/transaction_info_dto.dart';
import '../../../models/helpers/double_helper.dart';
import 'package:expenses/models/transaction_info.dart';
import 'package:expenses/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';

class TransactionHistoryView extends StatefulWidget {
  TransactionHistoryView({Key key}) : super(key: key);

  @override
  _TransactionHistoryViewState createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            child: BannerAdvertisementView(),
          ),
          Container(child: CurrentMonthView()),
          Container(child: MonhtlySummaryView()),
          Expanded(
            child: ChangeNotifierProvider(
                create: (context) => TransactionHistoryProvider(),
                child: TransactionInfoDtoList()),
          ),
        ],
      ),
    );
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
          return ListView.separated(
              itemBuilder: (context, count) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                    child: Container(
                      height: 60,
                    ),
                  ),
                );
              },
              separatorBuilder: (_, count) {
                return Padding(
                  padding: EdgeInsets.only(top: 0),
                );
              },
              itemCount: 4);
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
    TransactionHistoryProvider provider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              IconData(transactionInfo.transactionTypeIcon,
                                  fontFamily: 'MaterialIcons'),
                              color:
                                  Color(transactionInfo.transactionTypeColor),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                            ),
                            Text(
                              transactionInfo.transactionType,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                        ),
                        AutoSizeText(
                          getDateAndTimeString(transactionInfo.transactionDate),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        (transactionInfo.transactionCategoryName == 'expense')
                            ? Text(
                                '-' +
                                    DoubleHelper.convertDobleTo2DecimalPlaces(
                                        transactionInfo.transactionAmount),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .apply(color: Colors.red.withAlpha(190)))
                            : Text(
                                DoubleHelper.convertDobleTo2DecimalPlaces(
                                  transactionInfo.transactionAmount,
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .apply(color: Colors.green.withAlpha(190))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey[300],
                          ),
                          onPressed: () {
                            TransactionRepository()
                                .deleteTransaction(
                                    transactionInfo.transactionId)
                                .then((deletedId) {
                              provider.updateTransactionInfoDtosByMonth(
                                  monthProvider.currentYear,
                                  monthProvider.currentMonth);

                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text('Transaction info deleted'),
                                    FlatButton(
                                        child: Text('UNDO'),
                                        onPressed: () {
                                          TransactionRepository()
                                              .insertTransaction(TransactionInfo
                                                  .fromTransactionInfoDto(
                                                      transactionInfo));
                                          provider
                                              .updateTransactionInfoDtosByMonth(
                                                  monthProvider.currentYear,
                                                  monthProvider.currentMonth);
                                        })
                                  ],
                                ),
                              ));
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Padding(padding: const EdgeInsets.only(top: 10)),
              if (transactionInfo.transactionNote != null &&
                  transactionInfo.transactionNote != '')
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
                  child: Text(
                    transactionInfo.transactionNote,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .apply(fontSizeFactor: 1.1, color: Colors.grey[600]),
                  ),
                ),
            ],
          )),
    );
  }
}
