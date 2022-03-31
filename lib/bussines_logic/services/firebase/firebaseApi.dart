import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _dataBase = FirebaseFirestore.instance;

class FirebaseApi {

  static String? userId;

  static Future<void> addItem({
    required String userEmail,
    required DateTime dateCreated,
    required String userPassword,
    required String userFirstName,
    required String userLastName,
    required String? userId,
  }) async {
    DocumentReference usersDocument =
    _dataBase.collection('users').doc(userId);

    Map<String, dynamic> data = <String, dynamic>{
      "userEmail": userEmail,
      "dateCreated": dateCreated,
      "userPassword": userPassword,
      "userFirstName" : userFirstName,
      "userLastName" : userLastName,
    };



    await usersDocument
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));



  }
  static Future<void> getUserFirstAndLastName() async {
    DocumentReference userDocument = _dataBase.collection('users').doc(userId);

    //await userDocument.get()
  }

  static Future<void> createNotification({
    required String notificationTitle,
    required DateTime dateCreated,
    required DateTime dateSelected,
    required String notificationDescription,
    required String? userId,
  }) async {
    DocumentReference usersDocument =
    _dataBase.collection('users').doc(userId).collection("notifications").doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": notificationTitle,
      "dateCreated": dateCreated,
      "description": notificationDescription,
      "dateSelected" : dateSelected,
    };



    await usersDocument
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));



  }
}
FirebaseApi fApi = FirebaseApi();

