import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  // Repositories
  final _authRepo = Get.find<AuthenticationRepository>();
  final _userRepo = Get.find<UserRepository>();

  // Reactive user data
  final Rx<UserModel> userData = UserModel(
    UserID: '',
    UserName: '',
    email: '',
    password: '',
    UserType: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Fetch user data and update the reactive variable
  Future fetchUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      final data = await _userRepo.getUserDetails(email);
      userData.value = data;
    } else {
      Get.snackbar("Error", "Login to continue");
      return Future.error("Login to continue");
    }
  }

  // Fetch list of user repositories
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUser();

  // Update user record
  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
    await fetchUserData();  // Refresh user data after updating the record
  }
}
