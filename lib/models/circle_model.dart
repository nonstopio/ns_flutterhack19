import 'package:flutterhackathon/utils/app_strings.dart';
import 'package:meta/meta.dart';

class CircleModel {
  String id;
  String name;
  String description;
  String createdBy;
  String totalFunds;

  CircleModel({
    @required this.name,
    @required this.id,
    @required this.description,
    @required this.createdBy,
    @required this.totalFunds,
  });

  factory CircleModel.empty() => CircleModel(
        id: "",
        name: "",
        description: "",
        createdBy: "",
        totalFunds: "",
      );

  factory CircleModel.fromMap({
    @required Map data,
    @required String id,
  }) {
    try {
      return CircleModel(
        id: data['id'] ?? "",
        name: data[Strings.name] ?? "",
        description: data[Strings.designation] ?? "",
        createdBy: data[Strings.createdBy] ?? "",
        totalFunds: data[Strings.totalFunds] ?? "",
      );
    } on Exception catch (e, s) {
      print("CircleModel.fromMap Exception : $e\n$s");
    }

    return CircleModel.empty();
  }
}
