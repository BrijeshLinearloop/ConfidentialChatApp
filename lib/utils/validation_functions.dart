
import 'package:get/get.dart';

/// Checks if string is email.
bool isValidEmail(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
    isInputStringValid = true;
  }

  if (inputString != null) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Password should have,
/// at least a upper case letter
///  at least a lower case letter
///  at least a digit
///  at least a special character [@#$%^&+=]
///  length of at least 4
/// no white space allowed
bool isValidPassword(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
    isInputStringValid = true;
  }

  if (inputString != null) {
    // const pattern =
    //     r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';
    const pattern = r'^(?=.{8,}$)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\W).*$';
    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

bool isEmpty(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if (inputString == null || inputString.isEmpty) {
    isInputStringValid = true;
  }

  return isInputStringValid;
}

bool isValidZipCode(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
    isInputStringValid = true;
  }

  if (inputString != null) {
    // const pattern =
    //     r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';
    const pattern = r'^[A-Z]{2}\d{3}$';
    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}