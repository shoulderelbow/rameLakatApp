import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rame_lakat_app/bussines_logic/services/common/shared_prefs.dart';
import 'package:rame_lakat_app/bussines_logic/services/firebase/firebaseApi.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import '../../data/models/User.dart';
import '../common/app_styles.dart';
import '../common/common_views.dart';


class MyProfileWidget extends StatefulWidget {
  MyProfileWidget({required this.user});
  User user;
  @override
  State<MyProfileWidget> createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {

  File _imageFile = File("");

  @override
  Widget build(BuildContext context) {
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
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(150)),
                              ),
                              width: 190,
                              height: 190,
                              child: CircleAvatar(backgroundImage:
                              NetworkImage(widget.user.profileImage), radius: 40.0,),
                            ),
                            Positioned(
                              top: 150,
                              left: 140,
                              child: GestureDetector(
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
                                      BoxShadow(
                                        color: Colors.black54.withOpacity(0.4),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                      ),
                                    ], color: Color(0xFF94BBEE)),
                                    child: Icon(Icons.camera_alt, color: Colors.white),),
                              onTap: () async {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              width: 170,
                                              child: ElevatedButton(
                                                child: Text('Choose from gallery'),
                                                onPressed: () async {
                                                  final profileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                  setState(() {
                                                    _imageFile = File(profileImage!.path);
                                                  });
                                                  FirebaseStorage storage = FirebaseStorage.instance;
                                                  String fileName = _imageFile.path.substring(_imageFile.path.lastIndexOf("/"));
                                                  Reference firebaseStorageRef = storage.ref().child('ProfilePictures/$fileName');
                                                  UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
                                                  TaskSnapshot taskSnapshot = await uploadTask;
                                                  String internetPath = await firebaseStorageRef.getDownloadURL();
                                                  FirebaseApi.uploadImage(profileImage: internetPath, uniqueId: widget.user.uniqueId);

                                                  SharedPrefs().updateProfileImage(internetPath);

                                                  widget.user.profileImage = internetPath;
                                                  setState(() {

                                                  });
                                                }
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              child: ElevatedButton(
                                                child: Text('Take a picture'),
                                                onPressed: () async {
                                                  final profileImage = await ImagePicker().pickImage(source: ImageSource.camera);
                                                  setState(() {
                                                    _imageFile = File(profileImage!.path);
                                                  });
                                                  FirebaseStorage storage = FirebaseStorage.instance;
                                                  String fileName = _imageFile.path.substring(_imageFile.path.lastIndexOf("/"));
                                                  Reference firebaseStorageRef = storage.ref().child('ProfilePictures/$fileName');
                                                  UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
                                                  TaskSnapshot taskSnapshot = await uploadTask;
                                                  String internetPath = await firebaseStorageRef.getDownloadURL();
                                                  FirebaseApi.uploadImage(profileImage: internetPath, uniqueId: widget.user.uniqueId);

                                                  SharedPrefs().updateProfileImage(internetPath);

                                                  widget.user.profileImage = internetPath;
                                                  setState(() {

                                                  });
                                                }
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          (widget.user.firstName + " " + widget.user.lastName),
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.user.email,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Colors.black26,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text('Blood type'.tr(), style: TextStyle(fontWeight: FontWeight.w500),),
                                ),
                                userContainer('0-'),
                              ],
                            ),
                            SizedBox(width: 7,),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text('assignedDoctor'.tr(), style: TextStyle(fontWeight: FontWeight.w500),),
                                ),
                                userContainer('Ivan Ivanovic'),
                              ],
                            ),
                            SizedBox(width: 7,),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text('Age'.tr(), style: TextStyle(fontWeight: FontWeight.w500),),
                                ),
                                userContainer('28'),
                              ],
                            ),
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
                        Divider(thickness: 3),
                        Text('FirstName'.tr() + ": " + widget.user.firstName, style: userText(),),
                        SizedBox(height: 10),
                        Text('City'.tr() + ": " + widget.user.city, style: userText(),),
                      ],
                    ),
                  ),
                ),
    ),
                  ),
   ], ),
    ),
    );
  }
}


