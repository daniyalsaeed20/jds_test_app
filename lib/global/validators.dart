import 'package:form_field_validator/form_field_validator.dart';

class CustomValidators {

  final fieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Field cannot be empty'),
  ]);

  final emptyValidator = MultiValidator([]);

}
