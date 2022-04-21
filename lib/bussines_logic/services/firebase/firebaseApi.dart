import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/Doctor.dart';
import '../../../data/models/Institution.dart';
import 'package:rame_lakat_app/data/models/Disease.dart';

import '../../../data/models/News.dart';

final FirebaseFirestore _dataBase = FirebaseFirestore.instance;

class FirebaseApi {


  static String? userId;

  static Future<Institution> getInstitution(String id) async {
    var institutiondata = await _dataBase.collection("institutions").doc(id).get();

    Institution institution = Institution(name: institutiondata['name']);
    return institution;
  }

  static Future<Disease> getDisease(String id) async {
    var diseasesdata = await _dataBase.collection("diseases").doc(id).get();
    Disease disease = Disease(name: diseasesdata['name']);
    return disease;
  }

  static Future<Doctor> getDoctor(String id) async {
    var doctorData = await _dataBase.collection("doctors").doc(id).get();

    Doctor doctor = Doctor(firstName: doctorData["firstName"], lastName: doctorData["lastName"]);

    return doctor;
  }

  static Future<List<Doctor>> getDoctors() async {
    List<Doctor> doctors = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("doctors").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Doctor doctor = Doctor(firstName: data['firstName'], lastName: data['lastName'], fieldOfExpertise: data['fieldOfExpertise'], institution: data['institution'], phoneNumber: data['phoneNumber'], pictureLocation: data['pictureLocation'], uniqueId: data['uniqueId'], workingTimes: data['workingTimes']);
      doctors.add(doctor);
    }
    return doctors;
  }

  static Future<List<Disease>> getDiseases() async {
    List<Disease> diseases = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("diseases").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Disease disease = Disease(name: data['name']);
      diseases.add(disease);
    }
    return diseases;
  }

  static Future<List<Institution>> getInstitutions() async {
    List<Institution> institutions = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("institutions").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Institution institution = Institution(name: data['name'], adress: data['adress'], longDescription: data['longDescription'], shortDescription: data['shortDescription'], workingTimes: data['workingTimes']);
      institutions.add(institution);
    }
    return institutions;
  }

  static Future<List<News>> getNews() async {
    List<News> news = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("news").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      print(data);
      News novost = News(name: data['name'], type: data['type'],);
      news.add(novost);
    }
    print(news.length);
    return news;
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

