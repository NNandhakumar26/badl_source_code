import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class BouncingButton extends StatefulWidget {
  final String title;
  final VoidCallback voidCallback;
  BouncingButton({
    this.title = 'Done',
    required this.voidCallback,
  });

  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton> {
  double _scaleFactor = 1;

  _onPressed(BuildContext context) {
    Future.delayed(Duration(milliseconds: 248), () {
      widget.voidCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    // backgroundColor: Color(0xFF8185E2),
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BouncingWidget(
            scaleFactor: _scaleFactor,
            // duration: Duration(milliseconds: 500),
            onPressed: () => _onPressed(context),
            child: Container(
              height: 54,
              width: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                // color: Colors.white,
                // color: Color(0xFF8185E2),
                color: Style.nearlyDarkBlue.withOpacity(0.60),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: Style.button.copyWith(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    // color: Color(0xFF8185E2),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 40,
          // ),
          // BouncingWidget(
          //   scaleFactor: _scaleFactor,
          //   onPressed: () => _onPressed(context),
          //   stayOnBottom: true,
          //   child: Container(
          //     height: 60,
          //     width: 270,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(100.0),
          //       color: Colors.white,
          //     ),
          //     child: Center(
          //       child: Text(
          //         'Stay on bottom',
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           fontWeight: FontWeight.bold,
          //           color: Color(0xFF8185E2),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 40,
          // ),
          // BouncingWidget(
          //   scaleFactor: _scaleFactor,
          //   onPressed: () {
          //     _onPressed(context);
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       shape: BoxShape.circle,
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: Icon(Icons.add),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 40,
          // ),
          // BouncingWidget(
          //   scaleFactor: _scaleFactor,
          //   onPressed: () => _onPressed(context),
          //   child: Text(
          //     "Hello !",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 35,
          //     ),
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width * .5,
          //   child: Slider(
          //     activeColor: Colors.amber,
          //     inactiveColor: Colors.amberAccent,
          //     min: -5,
          //     max: 5,
          //     value: _scaleFactor,
          //     onChanged: (double newValue) {
          //       setState(() {
          //         _scaleFactor = newValue;
          //       });
          //     },
          //   ),
          // ),
          // Center(
          //   child: Text(
          //     "Scale factor = ${num.parse(_scaleFactor.toStringAsFixed(2))}",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 20,
          //     ),
          //   ),
          // ),
        ],
        // ),
      ),
    );
  }
}
