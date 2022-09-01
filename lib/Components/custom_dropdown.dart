import 'package:badl_app/modals/preference.dart';
import 'package:badl_app/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDown extends StatefulWidget {
  final SubComponent subComponent;
  final voidCallBack;

  CustomDropDown(
    this.subComponent,
    this.voidCallBack,
  );

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final itemsList = [
    'Dependent',
    'Needs Assistance',
    'Independent',
    'Not Applicable'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.subComponent.value!,
                style: Style.caption.copyWith(
                  fontSize: 14,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade600,
                ),
              ),
              16.height,
              SizedBox(
                width: Get.width,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: Get.width / 2.64,
                    padding: EdgeInsets.symmetric(
                      horizontal: 3,
                    ),
                    child: DropdownButtonFormField<String>(
                      iconEnabledColor: Style.nearlyDarkBlue.withOpacity(0.87),
                      style: Style.overline.copyWith(
                        letterSpacing: 0.2,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Style.nearlyDarkBlue,
                      ),
                      hint: Text(
                        'Select',
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Style.overline.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Style.nearlyDarkBlue.withOpacity(0.32),
                        ),
                      ),
                      elevation: 4,
                      value: widget.subComponent.response,
                      isExpanded: true,
                      validator: (value) =>
                          value == null ? 'Cannot Be Null' : null,
                      decoration: dropdownDecoration(),
                      items: itemsList
                          .map(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: widget.voidCallBack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration dropdownDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(
          color: Style.nearlyDarkBlue.withOpacity(0.8),
          width: 0.32,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(
          color: Colors.red.shade800,
          width: 0.60,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(
          color: Style.nearlyDarkBlue,
          width: 0.60,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(
          color: Style.nearlyDarkBlue,
          width: 0.60,
        ),
      ),
    );
  }
}
