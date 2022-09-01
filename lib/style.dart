import 'package:flutter/material.dart';

extension IntExtensions on int? {
  Widget get height => SizedBox(height: this?.toDouble());
  Widget get width => SizedBox(width: this?.toDouble());
}

class Style {
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color online = Color(0xFF4BCB1F);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
// headline1: TextStyle(
//     fontSize: 103,
//     fontWeight: FontWeight.w300,
//     letterSpacing: -1.5
//   ),
//   headline2: TextStyle(
//     fontSize: 64,
//     fontWeight: FontWeight.w300,
//     letterSpacing: -0.5
//   ),
//   headline3: TextStyle(
//     fontSize: 51,
//     fontWeight: FontWeight.w400
//   ),
//   headline4: TextStyle(
//     fontSize: 36,
//     fontWeight: FontWeight.w400,
//     letterSpacing: 0.25
//   ),

  static const TextTheme textTheme = TextTheme(
    headline5: headline5,
    headline6: headline6,
    subtitle2: subtitle2,
    bodyText2: bodyText2,
    bodyText1: bodyText1,
    button: button,
    subtitle1: subtitle1,
    caption: caption,
  );
  static const TextStyle headline5 = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 26,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle headline6 = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 21,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static const TextStyle subtitle1 = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );
  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  static const TextStyle bodyText1 = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static const TextStyle bodyText2 = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  static const TextStyle button = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );
  static const TextStyle overline = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  );

  static final boxDecoration = BoxDecoration(
      gradient: RadialGradient(
    colors: [
      Color(0xfffafafa),
      // Color(0xfff2f3f8),
      Color(0xffe3e5ed),
    ],
    center: Alignment.center,
    radius: 0.8,
  ));

  static InputDecoration decoration = InputDecoration(
    filled: true,
    fillColor: Style.notWhite.withOpacity(0.87),
    hintText: "Write Some Comments...",
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Style.nearlyDarkBlue,
        width: 0.3,
      ),
      borderRadius: BorderRadius.circular(4),
      gapPadding: 4,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Style.nearlyDarkBlue,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(4),
      gapPadding: 4,
    ),
    hintStyle: Style.caption,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Style.nearlyDarkBlue,
        width: 0.3,
      ),
      borderRadius: BorderRadius.circular(4),
      gapPadding: 4,
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),

    // labelText: 'First Name',
    labelStyle: TextStyle(
      fontSize: 14,
      // fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.87),
      letterSpacing: 1.0,
    ),
  );

  static InputDecoration inputTextDecoration({String title = ''}) {
    return InputDecoration(
      filled: true,
      fillColor: Style.nearlyWhite.withOpacity(0.87),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelText: title,
      floatingLabelStyle: Style.caption.copyWith(
        color: Style.nearlyDarkBlue,
        letterSpacing: 0.4,
        fontSize: 14,
      ),
      labelStyle: Style.subtitle2.copyWith(
        color: Style.lightText.withOpacity(0.32),
        // fontSize: 14,
        // letterSpacing: 0.4,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 0.4,
          color: Style.lightText,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 1.2,
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 1.6,
          color: Style.nearlyDarkBlue,
        ),
      ),
    );
  }

  static TextStyle errorText = TextStyle(
    fontSize: 12,
    color: Colors.white.withOpacity(0.87),
  );
  static Future loadingDialog(BuildContext context,
      {Widget? widget, String? title}) {
    return showDialog(
      context: context,
      builder: (context) => (widget != null)
          ? widget
          : CustomLoadingDialog(
              title: title ?? '',
            ),
    );
  }

  static navigate(BuildContext context, Widget widget) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  static navigateBack(BuildContext context, Widget widget) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}

class CustomLoadingDialog extends StatelessWidget {
  final String title;
  const CustomLoadingDialog({this.title = 'Loading...', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            CircularProgressIndicator(),
            16.width,
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Style.textTheme.bodyText2!.copyWith(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
