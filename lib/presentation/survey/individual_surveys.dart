import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/data/models/Question.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/survey/survey_quiz_widget.dart';


import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/Survey.dart';
import '../../data/models/parameter.dart';

String testName = "";
String testId = "";

class IndividualSurvey extends StatefulWidget {
  const IndividualSurvey({Key? key, required this.parameter}) : super(key: key);
  final Parameter parameter;
  @override
  State<IndividualSurvey> createState() => _IndividualSurveyState();
}

class _IndividualSurveyState extends State<IndividualSurvey> {
  List<Question> questions = [];
  List<Survey> tests = [];

  Future getQuestions() async {
    String diseaseId = widget.parameter.id;
    tests = await FirebaseApi.getSurveys();
    for(int i=0; i<tests.length; i++){
      if(tests[i].diseaseId == diseaseId){
        testId = tests[i].uniqueId ?? "";
        testName = tests[i].name ?? "";
      }
    }
    questions = await FirebaseApi.getQuestions(testId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getQuestions(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SurveyQuizWidget(questions: questions, name: testName,);
          }
        });
  }
  }




