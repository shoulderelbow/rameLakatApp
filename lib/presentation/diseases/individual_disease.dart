import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rame_lakat_app/bussines_logic/services/firebase/firebaseApi.dart';
import 'package:rame_lakat_app/data/models/parameter.dart';
import '../../data/models/Disease.dart';
import '../../data/models/Survey.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';

class IndividualDiseaseScreen extends StatefulWidget {
  const IndividualDiseaseScreen({Key? key, required this.parameter}) : super(key: key);
  final Parameter parameter;
  @override
  State<IndividualDiseaseScreen> createState() => _IndividualDiseaseScreenState();
}

class _IndividualDiseaseScreenState extends State<IndividualDiseaseScreen> {
  late Disease disease;
  late List<Survey> survey;

  Future<void> getDiseaseAndSurvey(String id) async {
    disease = await FirebaseApi.getDisease(id);
    survey = await FirebaseApi.getSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: appbarWithBack(context)),
      body: FutureBuilder(
        future: getDiseaseAndSurvey(widget.parameter.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
                value: 50,
              ));
            case ConnectionState.done:
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Image.network(disease.pictureLocation ?? ''),
                        height: 180,
                        width: 300,
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(child: Text(disease.name ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2)),
                      ),
                      Divider(color: AppColors.primaryDark, indent: 25, endIndent: 25, thickness: 1),
                      Html(
                        data: """${disease.diseaseDescription}""",
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(""),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 50, left: 200, right: 5),
                      //   child: Stack(
                      //     children: [
                      //       Visibility(
                      //         child: Container(
                      //           width: 160,
                      //           decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(10),
                      //               boxShadow: [BoxShadow(blurRadius: 0, color: Colors.white, spreadRadius: 0)]),
                                // child: TextButton(
                                //   onPressed: () {
                                //     final parameter = Parameter(id: disease.uniqueId ?? "");
                                //     Navigator.of(context).pushNamed("/individual_surveys", arguments: parameter);
                                //   },
                              //     child: Padding(
                              //       padding: EdgeInsets.only(left: 20),
                              //       child: Row(
                              //         children: [
                              //           Text("URADI TEST", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                              //           SizedBox(
                              //             width: 10,
                              //           ),
                              //           Icon(Icons.arrow_forward, color: Colors.black),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // visible: (widget.parameter.id == "CR5prXsNl8tyrDohozXg" ||  widget.parameter.id == "SVfcTdZ2eajCOaasgtCI") ? false : true
                            // ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Result: ${snapshot.data}');
              }
          }
        },
      ),
    );
  }
}
