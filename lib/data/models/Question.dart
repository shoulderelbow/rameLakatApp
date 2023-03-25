import 'package:rame_lakat_app/data/models/Answer.dart';

class Question{
  final String? name;
  final String? points;
  final String? questionId;
  final String? order;
  List<Answer> answers = [];

  Question({this.name, this.points, this.questionId, this.order});
}
