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
                  _individualQuestionContainer(),
                  _individualQuestionContainer(),
                  _individualQuestionContainer(),
                  _individualQuestionContainer(),
                  _individualQuestionContainer(),
                  _individualQuestionContainer(),
                  _individualQuestionContainer(),
                ]),
          ),
        ),
      ),
    );
  }

  Container _individualQuestionContainer() => Container(

        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 1.5,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '"From 1-10" questions placeholder',
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.commonTextColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 15,
            ),
            _radioChoiceRow(),
          ],
        ),
      );

  Row _radioChoiceRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _individualRadioChoice("1", 1),
          _individualRadioChoice("2", 2),
          _individualRadioChoice("3", 3),
          _individualRadioChoice("4", 4),
          _individualRadioChoice("5", 5),
          _individualRadioChoice("6", 6),
          _individualRadioChoice("7", 7),
          _individualRadioChoice("8", 8),
          _individualRadioChoice("9", 9),
          _individualRadioChoice("10", 10),
        ],
      );


  Expanded _individualRadioChoice(String radioNumber, int radioValue) {
    int _groupValue = 0;
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(radioNumber,
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.commonTextColor.withOpacity(1),
                      fontWeight: FontWeight.bold)),
              Radio(
                groupValue: _groupValue,
                value: radioValue,
                onChanged: (value) {
                  setState(() {
                    _groupValue = radioValue;
                  });
                },
              ),
            ],
          ),
        ),
      );}
}




// import 'package:flutter/material.dart';
// import 'package:rame_lakat_app/presentation/common/app_colors.dart';
//
// import '../common/common_views.dart';
//
// class QuestionnaireScreen extends StatefulWidget {
//   const QuestionnaireScreen({Key? key}) : super(key: key);
//
//   @override
//   _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
// }
//
// class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
//   int _groupValue = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: appbarWithBack(context)),
//       backgroundColor: AppColors.backGroundColor,
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(0),
//           alignment: Alignment.topCenter,
//           margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
//           child: SingleChildScrollView(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(),
//                   _individualQuestionContainer(),
//                   _individualQuestionContainer(),
//                   _individualQuestionContainer(),
//                   _individualQuestionContainer(),
//                   _individualQuestionContainer(),
//                   _individualQuestionContainer(),
//                   _individualQuestionContainer(),
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Container _individualQuestionContainer() => Container(
//     padding:
//     const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//         border: Border.all(
//           color: Colors.black.withOpacity(0.1),
//           width: 1.5,
//         )),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const Text(
//           '"From 1-10" questions placeholder',
//           style: TextStyle(
//               fontSize: 20,
//               color: AppColors.commonTextColor,
//               fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         _radioChoiceRow(),
//       ],
//     ),
//   );
//
//   Row _radioChoiceRow() => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       _individualRadioChoice("1", 1),
//       _individualRadioChoice("2", 2),
//       _individualRadioChoice("3", 3),
//       _individualRadioChoice("4", 4),
//       _individualRadioChoice("5", 5),
//       _individualRadioChoice("6", 6),
//       _individualRadioChoice("7", 7),
//       _individualRadioChoice("8", 8),
//       _individualRadioChoice("9", 9),
//       _individualRadioChoice("10", 10),
//     ],
//   );
//
//   Expanded _individualRadioChoice(String radioNumber, int radioValue) =>
//       Expanded(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey.withOpacity(0.1),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(5.0),
//             ),
//           ),
//           margin: const EdgeInsets.all(2),
//           padding: const EdgeInsets.all(0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(radioNumber,
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: AppColors.commonTextColor.withOpacity(1),
//                       fontWeight: FontWeight.bold)),
//               Radio(
//                 groupValue: _groupValue,
//                 value: radioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _groupValue = radioValue;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
// }
