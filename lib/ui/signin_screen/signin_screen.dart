


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reactnativetask/uitls/base_assets.dart';

import '../../uitls/base_colors.dart';
import '../../uitls/base_strings.dart';

class SignInScreen extends StatefulWidget {
   SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final firebaseAuthInstance = FirebaseAuth.instance;
   final GoogleSignIn googleSignIn = GoogleSignIn(
     scopes: ['email'],
   );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Image.asset(BaseAssets.signInBGImage),
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                    child: Text(BaseStrings.signInWelcomeText,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(BaseStrings.signInDescText,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
                    ),
                  ),
                ],
              ),
            ],
          ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: TextFormField(
                decoration:   InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: BaseColors.borderColor),
                    borderRadius: BorderRadius.circular(14)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: BaseColors.borderColor),
                      borderRadius: BorderRadius.circular(14)
                  ),
                  enabledBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(color: BaseColors.borderColor),
                      borderRadius: BorderRadius.circular(14)
                  ),
                  fillColor: BaseColors.textFromFieldColor,
                  label: const Text(BaseStrings.emailText,style: TextStyle(
                    color: BaseColors.backgroundBlueColor,
                    fontSize: 14
                  ),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: TextFormField(
                obscureText: true,
                decoration:   InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: BaseColors.borderColor),
                      borderRadius: BorderRadius.circular(14)
                  ),
                  enabledBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(color: BaseColors.borderColor),
                      borderRadius: BorderRadius.circular(14)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: BaseColors.borderColor),
                      borderRadius: BorderRadius.circular(14)
                  ),
                  fillColor: BaseColors.textFromFieldColor,
                  label: const Text(BaseStrings.passwordText,style: TextStyle(
                      color: BaseColors.backgroundBlueColor,
                      fontSize: 14
                  ),),
                ),
              ),
            ),


            Container(
              margin: const EdgeInsets.only(top: 16),
              height: 50,
              width: size.width*0.85,
              decoration: BoxDecoration(
                color: BaseColors.backgroundBlueColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child:
              Text(BaseStrings.loginText,style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: BaseColors.whiteColor),)),
            ),


            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: BaseColors.backgroundBlueColor,
                      thickness: 2,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(BaseStrings.orSignInWithText,style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 22,
                      color: BaseColors.backgroundBlueColor),),
                ),
                  Expanded(
                    child: Divider(
                      color: BaseColors.backgroundBlueColor,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterSocialButton(
                    onTap: () async {
                      try {
                        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                        final GoogleSignInAuthentication? googleAuth =
                        await googleUser?.authentication;
                        if (googleAuth != null) {
                          final credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth.accessToken,
                            idToken: googleAuth.idToken,
                          );
                          await firebaseAuthInstance.signInWithCredential(credential);
                        }
                      } catch (error) {
                        print(error);
                      }
                    },
                    buttonType: ButtonType.google, // Button type for different type buttons
                    mini: true,// for change icons colors
                  ),
                  const SizedBox(width: 30,),
                  FlutterSocialButton(
                    onTap: () async {
                      try {
                        var data =  await googleSignIn.signOut();
                        print(data);
                      } catch (error) {
                        print(error);
                      }
                    },
                    buttonType: ButtonType.apple, // Button type for different type buttons
                    mini: true,// for change icons colors
                  ),
                ],
              ),
            ),



          ],),
      ),
    );
  }
}
