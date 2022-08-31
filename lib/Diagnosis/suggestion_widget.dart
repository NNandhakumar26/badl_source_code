import 'package:badl_app/modals/preference.dart';
import 'package:badl_app/style.dart';
import 'package:flutter/material.dart';

class SuggestionWidget extends StatefulWidget {
  final String title;
  final List<Preference> preferenceList;
  const SuggestionWidget(
      {Key? key, required this.title, required this.preferenceList})
      : super(key: key);

  @override
  State<SuggestionWidget> createState() => _SuggestionWidgetState();
}

class _SuggestionWidgetState extends State<SuggestionWidget> {
  @override
  Widget build(BuildContext context) {
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
        ...widget.preferenceList
            .map(
              (e) => CheckboxListTile(
                value: e.isSelected,
                activeColor: Style.nearlyDarkBlue,
                onChanged: (value) {
                  widget.preferenceList[widget.preferenceList.indexOf(e)]
                      .isSelected = value ?? false;
                  setState(() {});
                },
                title: Text(
                  e.question ?? '',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black.withOpacity(0.60),
                        fontSize: 14,
                      ),
                ),
              ),
            )
            .toList(),
        doneButton(context),
      ],
    );
  }

  Widget doneButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 48,
        vertical: 8,
      ),
      child: FloatingActionButton.extended(
        onPressed: () {
          bool value = false;
          for (var item in widget.preferenceList) {
            if (item.isSelected == true) {
              value = true;
            }
          }
          if (value) {
            Navigator.pop(context, widget.preferenceList);
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
