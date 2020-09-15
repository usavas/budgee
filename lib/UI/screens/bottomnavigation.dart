import 'package:expenses/UI/screens/account/providers/mothly_totals_provider.dart';
import 'package:provider/provider.dart';

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
  int _selectedIndex = 0;
//  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Account(),
    TransactionHistory(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
            icon: Icon(Icons.settings),
            title: Text('Ayarlar'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[500],
        iconSize: 30,
        elevation: 20,
        backgroundColor: Theme.of(context).backgroundColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
