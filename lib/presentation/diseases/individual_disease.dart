import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
              return Center(child: CircularProgressIndicator(color: Colors.black, value: 50, ));
            case ConnectionState.done:
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image.network("https://static.toiimg.com/photo/msid-75449076/75449076.jpg?203156"),
                            height: 150,
                            width: 150,
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                          ),
                          Container(
                              child: Text(
                                  disease.name ?? '',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      Divider(color: AppColors.primaryDark, indent: 15, endIndent: 15, thickness: 1),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description of the disease - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "How to treat it".tr(),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Description of how to treat it - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap"),
                      ),
                      SizedBox(height: 50,),
                      Padding(
                        padding: EdgeInsets.only(top: 80, left: 200),
                        child: Stack(
                          children: [
                            Container(
                            width: 160,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(blurRadius: 0, color: Colors.white, spreadRadius: 0)]),
                            child: TextButton(
                              onPressed: (){
                              final parameter = Parameter(id: disease.uniqueId ?? "");
                              Navigator.of(context).pushNamed("/individual_surveys", arguments: parameter);
                            }, child:
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text("URADI TEST", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                                  SizedBox(width: 10,),
                                  Icon(Icons.arrow_forward, color: Colors.black),
                                ],
                              ),
                            ),
                            ),
                          ),
                          ],
                        ),
                      ),
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
