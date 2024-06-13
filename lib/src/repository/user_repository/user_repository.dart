import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:get/get.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
    static UserRepository get instance => Get.find();

    // Point application to database
    final _db = FirebaseFirestore.instance;

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

    Future<UserModel> getUserDetails(String email) async {
      final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
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
}
