import 'package:badl_app/diagnosis/question_controller.dart';
import 'package:badl_app/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SuggestionWidget extends StatefulWidget {
  final String title;
  final int referenceQuestionIndex;
  const SuggestionWidget({
    Key? key,
    required this.title,
    required this.referenceQuestionIndex,
  }) : super(key: key);

  @override
  State<SuggestionWidget> createState() => _SuggestionWidgetState();
}

class _SuggestionWidgetState extends State<SuggestionWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (QuestionController controller) {
        return SimpleDialog(
          title: Column(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Select The Appropriate Ones',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 10,
                    ),
              ),
            ],
          ),
          children: [
            for (int i = 0;
                i <
                    controller
                        .questionSetIndex(widget.referenceQuestionIndex)
                        .preferences
                        .length;
                i++)
              CheckboxListTile(
                value: controller
                    .questionSetIndex(widget.referenceQuestionIndex)
                    .preferences[i]
                    .isSelected,
                activeColor: Style.nearlyDarkBlue,
                onChanged: (value) {
                  controller
                      .questionSetIndex(widget.referenceQuestionIndex)
                      .preferences[i]
                      .isSelected = value ?? false;
                  setState(() {});
                },
                title: Text(
                  controller
                          .questionSetIndex(widget.referenceQuestionIndex)
                          .preferences[i]
                          .question ??
                      '',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black.withOpacity(0.60),
                        fontSize: 14,
                      ),
                ),
              ),
            doneButton(context, controller),
          ],
        );
      },
    );
  }

  Widget doneButton(BuildContext context, QuestionController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 48,
        vertical: 8,
      ),
      child: FloatingActionButton.extended(
        onPressed: () {
          bool value = false;
          for (var item in controller.nextQuestion.preferences) {
            if (item.isSelected == true) {
              value = true;
            }
          }
          if (value) {
            Navigator.pop(context);
          }
        },
        label: Text(
          'Done',
          style: Style.button,
        ),
        backgroundColor: Style.nearlyDarkBlue.withOpacity(0.87),
      ),
    );
  }
}
