import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/profile_controller.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
        appBar: PageTitleWidget(title: tEditProfile),  
        body: SingleChildScrollView(
          child: Container(
          padding: const EdgeInsets.all(tDefaultSize-20),
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasData){
                    UserModel userData = snapshot.data as UserModel;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            //Profile Image
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(image: AssetImage(tProfileImage)),
                              ),
                            ),
                    
                            //Edit button
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: tOrangeColor,
                                ),
                                child: const Icon(LineAwesomeIcons.camera_retro_solid, size:15.0, color: tBlackColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Form(child: Column(
                          children: [
                                                        // User ID
                            TextFormField(
                              initialValue: userData.UserID,
                              decoration: const InputDecoration(
                                label: Text('User ID'),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: tOrangeColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  borderSide: BorderSide(color: tOrangeColor),
                                ),
                                labelStyle: TextStyle(color: tBlackColor),
                              ),
                              enabled: false, // Make this field read-only
                            ),
                            const SizedBox(height: tFormHeight - 20),

                            //UserName
                            TextFormField(
                              initialValue: userData.UserName,
                              decoration: const InputDecoration(
                                label: Text(tUserName),
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: tOrangeColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  borderSide: BorderSide(color: tOrangeColor),
                                ),                      
                                labelStyle: TextStyle(color: tBlackColor),
                              )
                            ),
                    
                            const SizedBox(height: tFormHeight - 20),
                    
                            //Email
                            TextFormField(
                              initialValue: userData.email,
                              decoration: const InputDecoration(
                                label: Text(tEmail),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: tOrangeColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  borderSide: BorderSide(color: tOrangeColor),
                                ),                                                 
                                labelStyle: TextStyle(color: tBlackColor),
                              )
                            ),
                    
                            const SizedBox(height: tFormHeight - 20),                        
                    
                            //Password 
                            TextFormField(
                              initialValue: userData.password,
                              obscureText: true,
                              decoration: const InputDecoration(
                                label: Text(tPassword),
                                prefixIcon: Icon(
                                  Icons.fingerprint_outlined,
                                  color: tOrangeColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),       
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  borderSide: BorderSide(color: tOrangeColor),
                                ),                                          
                                labelStyle: TextStyle(color: tBlackColor),
                              )
                            ),
                    
                          const SizedBox(height: tFormHeight),  
                          
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                            onPressed: () => Get.to(()=> UpdateProfileScreen()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tOrangeColor,
                              padding: const EdgeInsets.symmetric(vertical: 10)
                            ),
                            child: const Text(
                              tEditProfile,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                    
                        const SizedBox(height: tFormHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: tJoined,
                                style: TextStyle(fontSize: 12),
                                children: [
                                  TextSpan(
                                    text: tJoinedDate,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                                  ),
                                ],
                              ),
                            ),
                    
                            ElevatedButton(
                              onPressed: (){}, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent.withOpacity(0.1),
                                elevation: 0,
                                foregroundColor: Colors.red,
                                shape: const StadiumBorder(),
                                side: BorderSide.none,
                              ),
                              child: const Text(tDelete),
                            )
                          ],
                        )
                        ],
                        )
                        )    
                      ],                
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  }else{
                    return const Center(child: Text('Something went wrong'));
                  }
                }else{
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
        ), 
      )   
    );
  }
}