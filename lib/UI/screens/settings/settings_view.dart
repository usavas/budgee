import 'package:expenses/UI/helper/in_app_purhcase_helper.dart';
import 'package:expenses/UI/screens/providers/in_app_purchase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/darktheme_provider.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    // final inAppPurchaseProvider = Provider.of<InAppPurchaseProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(right: 8, left: 8, top: 32, bottom: 12),
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                )),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Switch(
                  value: themeProvider.isDarkTheme,
                  onChanged: (bool value) {
                    themeProvider.isDarkTheme = !themeProvider.isDarkTheme;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                ),
                Text('Dark Theme'),
              ]),
            ),
            Divider(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Row(
            //     children: <Widget>[
            //       FlatButton(
            //         child: Text('Remove the ads'),
            //         onPressed: () async {
            //           inAppPurchaseProvider
            //               .purchaseProduct(InAppPurchaseHelper.removeAdsId);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // Divider(),
          ]),
        ),
      ),
    );
  }
}
