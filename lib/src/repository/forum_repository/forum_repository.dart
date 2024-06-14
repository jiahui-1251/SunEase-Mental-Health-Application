import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/exceptions/firebase_exceptions.dart';
import 'package:fyp/src/exceptions/platform_exceptions.dart';
import 'package:fyp/src/features/forum_post/models/forum_model.dart';
import 'package:get/get.dart';

class ForumPostRepository extends GetxController {
  static ForumPostRepository get instance => Get.find();

  //Variables
  final _db = FirebaseFirestore.instance;

  //Get all posts
  Future<List<ForumPostModel>> getAllPost() async {
    try{
      final snapshot = await _db.collection("ForumPost").get();
      final list = snapshot.docs.map((document) => ForumPostModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch(e) {
      throw TPlatformException(e.code).message;
    } on PlatformException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  //Create Post
  createPost (ForumPostModel post) async {
      //calling collections to add data to collections
      await _db.collection("Users").add(post.toJson()).whenComplete(
        ()=> Get.snackbar("Success", "Your post has been created.",
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
}

