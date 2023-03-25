import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rame_lakat_app/data/models/PostedMaterial.dart';
import 'package:rame_lakat_app/data/models/Simposium.dart';
import '../../../data/models/Answer.dart';
import '../../../data/models/Doctor.dart';
import '../../../data/models/Institution.dart';
import 'package:rame_lakat_app/data/models/Disease.dart';
import '../../../data/models/News.dart';
import '../../../data/models/Podcast.dart';
import '../../../data/models/Question.dart';
import '../../../data/models/Survey.dart';
import '../../../data/models/User.dart';

final FirebaseFirestore _dataBase = FirebaseFirestore.instance;

class FirebaseApi {


  static String? userId;

  static Future<Institution> getInstitution(String id) async {
    var institutiondata = await _dataBase.collection("institutions").doc(id).get();

    Institution institution = Institution(name: institutiondata['name'], pictureLocation: institutiondata['pictureLocation'], adress: institutiondata['adress'], workingTimes: institutiondata['workingTimes'], phone: institutiondata['phone'], longDescription: institutiondata['longDescription'], shortDescription: institutiondata['shortDescription']);
    return institution;
  }

  static Future<Simposium> getSymposium(String id) async {
    print("************************");
    var symposiumData = await _dataBase.collection('simposiums').doc(id).get();
    print(symposiumData);
    print("Aaaasdasdasdasdasdasdasdas");
    Timestamp timestamp = symposiumData['date'];
    DateTime date = timestamp.toDate();
    print(date);
    Simposium simposium = Simposium(name: symposiumData['name'], pictureLocation: symposiumData['pictureLocation'], subject: symposiumData['subject'], date: date, uniqueId: symposiumData['uniqueId'], symposiumText: symposiumData['symposiumText']);
    return simposium;
  }

  static Future<Disease> getDisease(String id) async {
    var diseasesdata = await _dataBase.collection("diseases").doc(id).get();
    Disease disease = Disease(name: diseasesdata['name'], uniqueId: diseasesdata['uniqueId'], pictureLocation: diseasesdata['pictureLocation'], diseaseDescription: diseasesdata['diseaseDescription']);
    return disease;
  }

  static Future<User> getUser(String id) async {
    var userDataa = await _dataBase.collection("users").doc(id).get();
    var userData = userDataa.data();
    print("**************");
    print(userData);
    print("**************");
    User user = User(firstName: userData!['userFirstName'], lastName: userData['userLastName'], userName: userData['userName'], email: userData['userEmail'], uniqueId: userData['uniqueId'], city: userData['city'], profileImage: userData['profileImage']);
    return user;
  }

  static Future<News> getNew(String id) async {
    var vesti = await _dataBase.collection("news").doc(id).get();
    Timestamp timestamp = vesti['date'];
    DateTime date = timestamp.toDate();
    News news = News(name: vesti['name'], pictureLocation: vesti['pictureLocation'], type: vesti['type'], uniqueId: vesti['uniqueId'], date: date, newsText: vesti['newsText']);
    return news;
  }

  static Future<List<User>> getUsers() async {
    List<User> users = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("users").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      User user = User(uniqueId: data['uniqueId'], firstName: data['userFistName'], lastName: data['userLastName'], email: data['userEmail'], userName: data['userName'], city: data['city'], profileImage: data['profileImage']);
      users.add(user);
    }
    return users;
  }
  
  static Future<List<Podcast>> getPodcasts() async {
    List<Podcast> podcasts = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("podcasts").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Podcast podcast = Podcast(name: data['name'], link: data['link']);
      podcasts.add(podcast);
    }
    return podcasts;
  }

  static Future<List<Survey>> getSurveys() async {
    List<Survey> surveys = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("tests").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Survey survey = Survey(name: data['name'], uniqueId: data['uniqueId'], pictureLocation: data['pictureLocation'], suggestion: data['suggesiton'], diseaseId: data['diseaseId'] );
      surveys.add(survey);
    }
    return surveys;
  }

  static Future<List<Simposium>> getSimposiums() async {
    List<Simposium> simposiums = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("simposiums").orderBy('date', descending: true).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      print("#OJJIOJIOJOIJOJ");
      print(data);
      Timestamp timestamp = data['date'];
      DateTime date = timestamp.toDate();
      Simposium simposium = Simposium(name: data['name'], date: date, uniqueId: data['uniqueId'], subject: data['subject'], pictureLocation: data['pictureLocation'], symposiumText: data['symposiumText']);
      simposiums.add(simposium);
    }
    return simposiums;
  }

  static Future<List<Doctor>> getDoctors(String id) async {
    List<Doctor> doctors = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("institutions").doc(id).collection("doctors").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var doctorData = querySnapshot.docs[i].data() as Map;
      Doctor doctor = Doctor(name: doctorData["name"], email: doctorData["email"], phone: doctorData["phone"], fieldOfExpertise: doctorData["fieldOfExpertise"], pictureLocation: doctorData['pictureLocation']);
      doctors.add(doctor);
    }
    return doctors;
  }

  static Future<List<Disease>> getDiseases() async {
    List<Disease> diseases = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("diseases").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Disease disease = Disease(name: data['name'], pictureLocation: data['pictureLocation'], uniqueId: data['uniqueId'], diseaseDescription: data['diseaseDescription']);
      diseases.add(disease);
    }
    return diseases;
  }

  static Future<List<Institution>> getInstitutions() async {
    List<Institution> institutions = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("institutions").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Institution institution = Institution(name: data['name'], adress: data['adress'], longDescription: data['longDescription'], shortDescription: data['shortDescription'], workingTimes: data['workingTimes'], pictureLocation: data['pictureLocation'], uniqueId: data['uniqueId']);
      institutions.add(institution);
    }
    return institutions;
  }

  static Future<List<News>> getNews() async {
    List<News> news = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("news").orderBy('date', descending: true).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Timestamp t = data['date'];
      DateTime date = t.toDate();
      News novost = News(name: data['name'], type: data['type'], pictureLocation: data['pictureLocation'], date: date, uniqueId: data['uniqueId'], newsText: data['newsText']);
      news.add(novost);
    }

    print(news.length);
    return news;
  }


  static Future<List<Question>> getQuestions(String testId) async {
    List<Question> questions = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("tests").doc(testId).collection("questions").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Question question = Question(name: data['name'], points: data['points'], questionId: data['questionId'], order: data['order']);
      List<Answer> answers = await getAnswers(data['questionId'], testId);
      question.answers = answers;

      questions.add(question);
    }
    print(questions.length);
    return questions;
  }

  static Future<List<Answer>> getAnswers(String questionId, String testId) async {
    List<Answer> answers = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("tests").doc(testId).collection("questions").doc(questionId).collection("answers").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      Answer answer = Answer(name: data['name'], uniqueId: data['uniqueId']);
      answers.add(answer);
    }
    return answers;
  }

  static Future<List<PostedMaterial>> getPostedMaterials() async {
    List<PostedMaterial> postedMaterials = [];
    QuerySnapshot querySnapshot = await _dataBase.collection("materials").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var data = querySnapshot.docs[i].data() as Map;
      PostedMaterial postedMaterial = PostedMaterial(name: data['name'], type: data['type'], link: data['link'],);
      postedMaterials.add(postedMaterial);
    }
    return postedMaterials;
  }
  static Future<void> uploadImage({
    required String profileImage,
    required String uniqueId,
  }) async {
    DocumentReference usersDocument = _dataBase.collection('users').doc(uniqueId);

    Map<String, dynamic> data = <String, dynamic>{
      "profileImage": profileImage,
    };

    await usersDocument
        .update(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> addUser({
    required String userEmail,
    required DateTime dateCreated,
    required String userPassword,
    required String userFirstName,
    required String userLastName,
    required String userName,
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
      "userName" : userName,
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

