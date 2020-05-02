import 'package:flutter/material.dart';

class CustomMultiChildLayoutDemo extends StatelessWidget {
  const CustomMultiChildLayoutDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Container(
          child: CustomMultiChildLayout(
            delegate: YourLayoutDelegate(),
            children: [
              LayoutId(
                id: 1, // The id can be anything, i.e. any Object, also an enum value.
                child: Text(
                    'Widget one'), // This is the widget you actually want to show.
              ),
              LayoutId(
                id: 2, // You will need to refer to that id when laying out your children.
                child: Text('Widget two'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YourLayoutDelegate extends MultiChildLayoutDelegate {
  YourLayoutDelegate({this.position});

  final Offset position;

  @override
  void performLayout(Size size) {
    // `size` is the size of the `CustomMultiChildLayout` itself.

    Size leadingSize = Size
        .zero; // If there is no widget with id `1`, the size will remain at zero.
    // Remember that `1` here can be any **id** - you specify them using LayoutId.
    if (hasChild(1)) {
      leadingSize = layoutChild(
        1, // The id once again.
        BoxConstraints.loose(
            size), // This just says that the child cannot be bigger than the whole layout.
      );
      // No need to position this child if we want to have it at Offset(0, 0).
    }

    if (hasChild(2)) {
      final secondSize = layoutChild(
        2,
        BoxConstraints(
          // This is exactly the same as above, but this can be anything you specify.
          // BoxConstraints.loose is a shortcut to this.
          maxWidth: size.width,
          maxHeight: size.height,
        ),
      );

      positionChild(
        2,
        Offset(
          leadingSize.width, // This will place child 2 to the right of child 1.
          size.height / 2 - secondSize.height / 2, // Centers the second child vertically.
        ),
      );
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
