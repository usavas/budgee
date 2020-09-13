import 'package:admob_flutter/admob_flutter.dart';
import 'package:expenses/UI/helper/admob_helper.dart';
import 'package:expenses/UI/screens/widgets/advertisement_placeholder.dart';
import 'package:flutter/material.dart';

class BannerAdvertisementView extends StatelessWidget {
  const BannerAdvertisementView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getAdWidget();
  }

  Widget _getAdWidget() {
    Admob.initialize(AdmobHelper.admobAppId);
    return Container(
        child: AdmobBanner(
      adUnitId: AdmobHelper.admobBannerAdId,
      adSize: AdmobBannerSize.FULL_BANNER,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    ));
  }

  void handleEvent(AdmobAdEvent event, args, String s) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('Admob banner loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob banner opened!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob banner failed to load. Error code: ${args['errorCode']}');
        break;
      case AdmobAdEvent.clicked:
        print('clicked');
        break;
      case AdmobAdEvent.impression:
        print('impression');
        break;
      default:
        print('default event run');
        break;
    }
  }
}
