import 'dart:convert';

PackageModel packageModelFromJson(String str) => PackageModel.fromJson(json.decode(str));

String packageModelToJson(PackageModel data) => json.encode(data.toJson());

class PackageModel {
    PackageModel({
        required this.packages,
    });

    List<Package> packages;

    factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    };
}

class Package {
    Package({
        required this.description,
        required this.pickup,
        required this.delivery,
    });

    String description;
    String pickup;
    String delivery;

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        description: json["description"],
        pickup: json["pickup"],
        delivery: json["delivery"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "pickup": pickup,
        "delivery": delivery,
    };
}
