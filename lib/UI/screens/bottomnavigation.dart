import 'package:expenses/UI/screens/providers/page_index_provider.dart';
import 'package:provider/provider.dart';
import 'statistics/monthly_transaction_type_totals.dart';
import 'settings/settings.dart';
import 'transactionhistory/transaction_history.dart';
import 'package:flutter/material.dart';
import 'account/account_home.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() {
    return _BottomNavigationState();
  }
}

class _BottomNavigationState extends State<BottomNavigation> {
  static List<Widget> _widgetOptions = <Widget>[
    Account(),
    TransactionHistory(),
    MonthlyTotalStatsDetailed(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageIndexProvider>(
        create: (context) => PageIndexProvider(),
        child: Consumer<PageIndexProvider>(
            builder: (context, pageIndexProvider, child) {
          return Scaffold(
            body: SafeArea(
                child: _widgetOptions.elementAt(pageIndexProvider.getIndex())),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  title: Text('Income/Expense'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.all_inclusive),
                  title: Text('History'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.assessment), title: Text('Statistics')),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
              currentIndex: pageIndexProvider.getIndex(),
              unselectedItemColor: Colors.grey[500],
              iconSize: 30,
              elevation: 20,
              backgroundColor: Theme.of(context).backgroundColor,
              onTap: ((index) {
                pageIndexProvider.setSelectedIndex(index);
              }),
            ),
          );
        }));
  }
}
