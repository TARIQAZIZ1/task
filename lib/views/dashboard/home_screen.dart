import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/views/authentication_modul/login_screen.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 40.h,
              width: 160.w,
              child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogInScreen()),
                          (route) => true);
                    });
                  },
                  child: const Center(
                    child: Text(
                      'Logout',
                    ),
                  )),
            )));
  }
}
