import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_styles.dart';
import '../common/common_views.dart';


class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: FutureBuilder(
          future: getDoctor(),
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
                  child: Center(
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Icon(Icons.arrow_back)),
                                ),
                                Column(
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
                                    "USERNAME",
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "useremail@gmail.com",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      userContainer('KRVNA GRUPA'),
                                      SizedBox(width: 10),
                                      userContainer('LEKAR'),
                                      SizedBox(width: 10),
                                      userContainer('GODINE'),
                                    ],
                                  ),
                                ],
                              ),],
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
                                      Text('City'.tr(), style: userText(),),
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
Future<void> getDoctor ()async {
  print("***********");
}

