import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';

import '../common/common_views.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: appbarWithBack(context)),
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(0),
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                  _individualQuestion(),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _individualQuestion() => Container(
        margin: const EdgeInsets.all(10),
        padding:
            const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 1.5,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you coughing?',
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.commonTextColor,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: const Text("Yes"),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: const Text("No"),
                )
              ],
            )
          ],
        ),
      );
}
