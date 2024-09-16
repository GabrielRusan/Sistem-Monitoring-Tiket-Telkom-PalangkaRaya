import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  empty,
  notStartingWithZero,
  invalidLength,
  containsNonNumeric,
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _numericRegex = RegExp(r'^\d+$');

  @override
  PhoneNumberValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return PhoneNumberValidationError.empty;
    }
    if (!value!.startsWith('0')) {
      return PhoneNumberValidationError.notStartingWithZero;
    }
    if (!_numericRegex.hasMatch(value)) {
      return PhoneNumberValidationError.containsNonNumeric;
    }
    if (value.length < 10 || value.length > 16) {
      return PhoneNumberValidationError.invalidLength;
    }
    return null; // No error, the phone number is valid.
  }
}
