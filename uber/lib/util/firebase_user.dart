import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/model/user_model.dart';

class FirebaseUser {
  static User getCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;

    return auth.currentUser;
  }

  static Future<UserModel> getLoggedUserData() async {
    User firebaseUser = getCurrentUser();
    String userId = firebaseUser.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await db.collection("users")
      .doc(userId)
      .get();


    Map<String, dynamic> data = snapshot.data();
    String kindOfUser = data["kindOfUser"];
    String email = data["email"];
    String username = data["username"];

    UserModel userModel = UserModel();

    userModel.userId = userId;
    userModel.userKind = kindOfUser;
    userModel.userEmail = email;
    userModel.username = username;

    return userModel;
  }
}