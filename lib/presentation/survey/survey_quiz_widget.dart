import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/models/Question.dart';
import '../common/app_colors.dart';


class SurveyQuizWidget extends StatefulWidget {
  SurveyQuizWidget({required this.questions, required this.name});
  List<Question> questions;
  String name;

  @override
  State<SurveyQuizWidget> createState() => _SurveyQuizWidgetState();
}

class _SurveyQuizWidgetState extends State<SurveyQuizWidget> {
  int index = 0;
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.backGroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (widget.questions[index].order ?? '') + "/" + widget.questions.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
        leading: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Text(
                    widget.questions[index].name ?? '',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.questions[index].answers.length,
              itemBuilder: (BuildContext context, int index1) {
                return GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black54, spreadRadius: 1)],
                        borderRadius: BorderRadius.circular(10),
                        color: widget.questions[index].answers[index1].isSelected == true ? Color(0xFFC1E9B2): Colors.white,
                      ),
                      height: 70,
                      width: 60,
                      child: Text(widget.questions[index].answers[index1].name,
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700), textAlign: TextAlign.left),
                      padding: EdgeInsets.all(15),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.questions[index].answers[index1].isSelected = !widget.questions[index].answers[index1].isSelected;
                      isEnabled = false;
                      for (int i = 0; i < widget.questions[index].answers.length; i++) {
                        if (widget.questions[index].answers[i].isSelected) {
                          isEnabled = true;
                        }
                      }

                    });
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    // boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black54, spreadRadius: 2)],
                    color: isEnabled ? Color(0xFFc5d4ed) : Color(0xFF9B9797),
                  ),
                  width: 500,
                  height: 70,
                  child: Text("Next".tr(),
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black), textAlign: TextAlign.center),
                  padding: EdgeInsets.all(15),
                ),
                onTap: () {
                  if (isEnabled) {
                    if (index < widget.questions.length - 1) {
                      setState(() {
                        index++;
                        isEnabled = false;
                      });
                    } else {
                      index = 0;
                      Navigator.of(context).pushNamed('/survey_results');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
