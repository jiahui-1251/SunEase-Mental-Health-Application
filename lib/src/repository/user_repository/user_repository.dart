import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:get/get.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
    static UserRepository get instance => Get.find();

    // Point application to database
    final _db = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;

    createUser (UserModel user) async {
      //calling collections to add data to collections
      await _db.collection("Users").add(user.toJson()).whenComplete(
        ()=> Get.snackbar("Success", "Your account has been created.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: tGreenColor.withOpacity(0.1),
          colorText: tGreenColor),
      )
      .catchError((error, StackTrace){
        Get.snackbar("Error", "Something went wrong. Please try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: tRedColor.withOpacity(0.1),
        colorText: tRedColor);
        print(error.toString());
      });
    }

Future<UserModel?> getUserDetails(String email) async {
  final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
  if (snapshot.docs.isEmpty) {
    return null; // Or handle this case appropriately (e.g., throw a custom exception)
  }
  final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  return userData;
}

    Future<List<UserModel>> allUser() async {
      final snapshot = await _db.collection("Users").get();
      final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return userData;
    }

    Future<void> updateUserRecord(UserModel user) async {
      await _db.collection("Users").doc(user.UserID).update(user.toJson());
    }

  Future<void> deleteUser(String userId) async {
    try {
      // Delete user from Firebase Authentication
      User? user = _auth.currentUser;
      if (user != null && user.uid == userId) {
        await user.delete();
      } else {
        throw Exception("User not authenticated or user ID mismatch");
      }

      // Delete user's document from Firestore
      final snapshot = await _db.collection("Users").where("UserID", isEqualTo: userId).get();
      for (var doc in snapshot.docs) {
        await _db.collection("Users").doc(doc.id).delete();
      }

      Get.snackbar("Success", "User has been deleted.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: tGreenColor.withOpacity(0.1),
          colorText: tGreenColor);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: tRedColor.withOpacity(0.1),
          colorText: tRedColor);
      print(e.toString());
    }
  }
}
