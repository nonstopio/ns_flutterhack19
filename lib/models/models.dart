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
        id: id,
        name: data[Strings.name] ?? "",
        description: data[Strings.description] ?? "",
        createdBy: data[Strings.createdBy] ?? "",
        totalFunds: data[Strings.totalFunds] ?? "",
      );
    } on Exception catch (e, s) {
      print("CircleModel.fromMap Exception : $e\n$s");
    }

    return CircleModel.empty();
  }
}

class Expense {
  String id;
  String amount;
  String description;
  String createdBy;
  String name;
  String image;
  String like;
  String dislike;

  Expense({
    @required this.amount,
    @required this.id,
    @required this.description,
    @required this.createdBy,
    @required this.image,
    @required this.name,
    @required this.like,
    @required this.dislike,
  });

  factory Expense.empty() => Expense(
        id: "",
        amount: "0",
        description: "",
        createdBy: "",
        name: "",
        like: "0",
        dislike: "0",
        image: "",
      );

  factory Expense.fromMap({
    @required Map data,
    @required String id,
  }) {
    try {
      return Expense(
        id: id,
        amount: data[Strings.amount] ?? "0",
        image: data[Strings.image] ?? "",
        name: data[Strings.name] ?? "",
        description: data[Strings.description] ?? "",
        createdBy: data[Strings.createdBy] ?? "",
        like: data[Strings.like] ?? "0",
        dislike: data[Strings.dislike] ?? "0",
      );
    } on Exception catch (e, s) {
      print("CircleModel.fromMap Exception : $e\n$s");
    }

    return Expense.empty();
  }
}
