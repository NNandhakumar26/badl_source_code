import 'package:badl_app/chat/chat_screen.dart';
import 'package:badl_app/diagnosis/question_controller.dart';
import 'package:badl_app/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyAppBar extends StatelessWidget {
  CompanyAppBar({
    Key? key,
  }) : super(key: key);
  final QuestionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(),
      shadowColor: Style.nearlyDarkBlue.withOpacity(0.30),
      backgroundColor: Style.nearlyDarkBlue.withOpacity(0.60),
      elevation: 0,
      leadingWidth: 0,
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            Get.to(ChatScreen());
          },
          icon: Icon(
            Icons.contact_support_rounded,
            size: 26,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 8,
        )
      ],
      title: Text(
        //TODO: CHECK HERE...
        controller.displayTitle,
        style: Style.headline6.copyWith(
          color: Colors.white,
          letterSpacing: 0.8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
