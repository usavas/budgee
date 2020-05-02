import 'package:flutter/material.dart';

class AdvertisementPlaceHolder extends StatelessWidget {
  const AdvertisementPlaceHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all()),
      child: Center(child: Text("Advertisement here")),
    );
  }
}
