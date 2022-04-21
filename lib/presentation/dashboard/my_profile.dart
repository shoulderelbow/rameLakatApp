import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/bussines_logic/services/firebase/firebaseApi.dart';
import 'package:rame_lakat_app/data/models/Doctor.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_styles.dart';

import '../common/common_views.dart';
import 'drawer.dart';

class DoctorsCard extends StatefulWidget {
  DoctorsCard({Key? key}) : super(key: key);

  @override
  State<DoctorsCard> createState() => _DoctorsCardState();
}

class _DoctorsCardState extends State<DoctorsCard> {
  late Doctor doctor;

  Future<void> getDoctor(String id) async {
    doctor = await FirebaseApi.getDoctor(id);
  }

  @override
  void initState() {
    getDoctor('8P7UsK2Ccwh2w5qH9ggq');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments;
    // print("*********************");
    // print(args);
    // print("*********************");
    // // getDoctor(args!["id"] ?? "Nece");

    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder(
          future: getDoctor('8P7UsK2Ccwh2w5qH9ggq'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                  ),
                );
              case ConnectionState.done:
                return SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26, spreadRadius: 2)],
                                  ),
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundImage: NetworkImage(
                                        'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8='),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  doctor.firstName ?? "prazno",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "alekmacic123@gmail.com",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: Colors.black26,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    userContainer('UPISI KRVNU GRUPU'),
                                    SizedBox(width: 10),
                                    userContainer('UPISI LEKARA'),
                                    SizedBox(width: 10),
                                    userContainer('UPISI GODINE'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Card(
                              margin: EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text('Personal information'.tr(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black87),),
                                      SizedBox(),
                                      Divider(thickness: 3,),
                                      Text('Age'.tr(), style: userText(),),
                                      SizedBox(height: 10,),
                                      Text('Date of birth'.tr(), style: userText(),),
                                      SizedBox(height: 10,),
                                      Text('State'.tr(), style: userText(),),
                                      SizedBox(height: 10,),
                                      Text('City'.tr(), style: userText(),),
                                      SizedBox(height: 10,),
                                      Text('Gender'.tr(), style: userText(),),
                                      SizedBox(height: 10,),
                                      Text('Blood type'.tr(), style: userText(),),
                                      SizedBox(height: 10,),
                                      Text('Assigned doctor'.tr(), style: userText(),),
                                      SizedBox(height: 10,),
                                      Text('Telephone number'.tr(), style: userText(),),
                                  ],
                                ),
                              ),
                            ),
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
          }),
    );
  }
}


