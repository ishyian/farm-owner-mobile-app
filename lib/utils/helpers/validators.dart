import 'package:easy_localization/easy_localization.dart';
import 'package:queen_validators/queen_validators.dart';

class Validators {
  Validators._();
  static TextValidationRule isRequired() {
    return IsRequired("this_field_is_required".tr());
  }

  static TextValidationRule isEmail() {
    return IsEmail("invalid_email".tr());
  }

  static List<TextValidationRule> isPassword() {
    return [
      isRequired(),
      minLength6Number(),
    ];
  }

  static TextValidationRule minLength6Number() {
    return MinLength(6, "password_min_length".tr());
  }

  static TextValidationRule phoneNumber() {
    return MinLength(9, "invalid_phone_number".tr());
  }

  static String? isSamePassword({String? password, String? confirmPassword}) {
    if (confirmPassword == null) return "enter_confirm_password".tr();
    if (password == confirmPassword) return null;
    return "confirm_password_mismatch".tr();
  }
}
