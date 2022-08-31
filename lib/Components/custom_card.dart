import 'package:badl_app/style.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget widget;
  const CustomCardWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 8,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        shadowColor: Style.nearlyDarkBlue.withOpacity(0.16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 4,
          ),
          child: widget,
        ),
      ),
    );
  }
}
