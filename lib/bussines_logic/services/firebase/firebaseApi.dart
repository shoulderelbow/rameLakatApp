import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _dataBase = FirebaseFirestore.instance;

class FirebaseApi {


  static String? userId;

  static Future getDocs() async {
    List a = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("doctors").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      a.add(querySnapshot.docs[i].data());
    }
    return a;
  }

  static Future<void> addUser({
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

  static Future<void> addDoctor({
    required String firstName,
    required DateTime dateOfBirth,
    required String lastName,
    required String fieldOfExpertise,
    required String medicalInstitution,
    required int phoneNumber,
    required String workingTimes,
    required String uniqueId,
    required String pictureLocation,
  }) async {
    DocumentReference usersDocument =
    _dataBase.collection('doctors').doc(uniqueId);

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "fieldOfExpertise" : fieldOfExpertise,
      "institution" : medicalInstitution,
      "phoneNumber" : phoneNumber,
      "workingTimes": workingTimes,
      "uniqueId":uniqueId,
      "pictureLocation":pictureLocation,
    };

    await usersDocument
        .set(data)
        .whenComplete(() => print("Added doctor to the database"))
        .catchError((e) => print(e));
  }
  static Future<void> addMedicalInstitution({
    required String name,
    required String shortDescription,
    required String longDescription,
    required String address,
    required int phoneNumber,
    required String workingTimes,
    required String uniqueId,
    required String pictureLocation,
  }) async {
    DocumentReference usersDocument =
    _dataBase.collection('institutions').doc(uniqueId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "shortDescription": shortDescription,
      "longDescription": longDescription,
      "address" : address,
      "phoneNumber" : phoneNumber,
      "workingTimes": workingTimes,
      "uniqueId":uniqueId,
      "pictureLocation":pictureLocation,
    };

    await usersDocument
        .set(data)
        .whenComplete(() => print("Added medical institution to the database"))
        .catchError((e) => print(e));
  }




  Future<void> getIndividualDoctor({required String uniqueId}) async {

    await _dataBase
        .collection('doctors')
        .doc(uniqueId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data();
    });
  }

  Future<void> getIndividualInstitution({required String uniqueId}) async {

    await _dataBase
        .collection('institutions')
        .doc(uniqueId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data();
    });
  }

  Future<void> getAllInstitutions() async {
    await _dataBase
        .collection('institutions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        return doc;
      }
    });
  }
}

