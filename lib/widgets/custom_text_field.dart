import 'package:confidential_chat_app/utils/constants_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_constant.dart';
import '../utils/math_utils.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  FormFieldValidator<String>? validator;
  int? maxLines = 1;
  TextEditingController? controller;
  TextInputAction? textInputAction = TextInputAction.next;
  Widget? suffixIcon;
  bool obscureText = false;
  TextInputType? keyboardType = TextInputType.text;
  bool? isEnabled = false;
  BoxConstraints? suffixIconConstraints;
  bool? showCapital = false;
  TextCapitalization textCapitalization = TextCapitalization.sentences;
  List<TextInputFormatter>? textInputFiler;

  ///An common list view with pagination functionalities
  CustomTextField(
      {this.label,
      required this.hint,
      this.validator,
      this.maxLines,
      this.controller,
      this.textInputAction,
      this.suffixIcon,
      this.keyboardType,
      required this.obscureText,
      this.isEnabled,
      this.showCapital,
      this.textInputFiler,
      this.suffixIconConstraints});

  @override
  Widget build(BuildContext context) {
    if (showCapital != null) {
      textCapitalization = showCapital!
          ? TextCapitalization.characters
          : TextCapitalization.sentences;
    }

    if (suffixIcon != null) {
      suffixIconConstraints =
          BoxConstraints(minWidth: getSize(24.00), minHeight: getSize(24.00));
    }

    return Container(
        width: getHorizontalSize(
          311.00,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (label != null)
              Padding(
                padding: EdgeInsets.only(
                  right: getHorizontalSize(
                    10.00,
                  ),
                ),
                child: Text(
                  label!,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: ColorConstant.colorGrey,
                    fontSize: getFontSize(
                      14,
                    ),
                    fontFamily: ConstantsClass.fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                top: getVerticalSize(
                  8.00,
                ),
              ),
              child: TextFormField(
                enabled: isEnabled,
                controller: controller,
                maxLines: obscureText ? 1 : maxLines,
                validator: validator,
                textCapitalization: textCapitalization,
                inputFormatters: textInputFiler,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: obscureText,
                textInputAction: textInputAction,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: ColorConstant.colorBalck,
                      fontSize: getFontSize(
                        14,
                      ),
                      fontFamily: ConstantsClass.fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          0.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.colorGrey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          0.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.colorGrey,
                        width: 1,
                      ),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.only(
                      left: getHorizontalSize(
                        10.00,
                      ),
                      top: getVerticalSize(
                        14.00,
                      ),
                      bottom: getVerticalSize(
                        14.00,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          0.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.colorGrey,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          0.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.colorGrey,
                        width: 1,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: ColorConstant.colorRed,
                      fontSize: getFontSize(
                        10.0,
                      ),
                      fontFamily: 'Advent Pro',
                      fontWeight: FontWeight.w400,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          0.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.colorGrey,
                        width: 1,
                      ),
                    ),
                    suffixIcon: suffixIcon,
                    suffixIconConstraints: suffixIconConstraints),
                style: TextStyle(
                  color: ColorConstant.colorBalck,
                  fontSize: getFontSize(
                    14.0,
                  ),
                  fontFamily: 'Advent Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ));
  }
}
