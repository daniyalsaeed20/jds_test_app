import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    required this.code,
    required this.description,
    required this.package,
  });

  String code;
  String description;
  String package;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        code: json["code"],
        description: json["description"],
        package: json["package"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "package": package,
      };
}
