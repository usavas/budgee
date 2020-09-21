import 'package:flutter/material.dart';

class AdvertisementPlaceHolderView extends StatelessWidget {
  const AdvertisementPlaceHolderView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border.all()),
      child: Center(child: Text("Advertisement here")),
    );
  }
}
