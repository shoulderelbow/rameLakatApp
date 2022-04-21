import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rame_lakat_app/data/models/User.dart' as user_model;

class UserAuth {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore fireStore;

  UserAuth({required  this.firebaseAuth, required this.fireStore});

  Future<user_model.User> signInWithCredentials(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    var document = await fireStore.collection('users').doc(firebaseAuth.currentUser?.uid ?? '').get();
    var data = document.data();
    return user_model.User(firstName: data!['userFirstName'], lastName: data['userLastName'], email: data['userEmail']);
  }

  Future<UserCredential> signUp(String email, String password) async {
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<Future<List>> signOut() async {
    return Future.wait([firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }
}
