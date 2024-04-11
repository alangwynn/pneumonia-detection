
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pneumonia_detection/features/login/presentation/widgets/widgets.dart';
import 'package:pneumonia_detection/helpers/assets_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const routeName = '/login-screen'; 

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const Placeholder(),

              SizedBox(
                height: screenHeight * 0.4,
                child: Image.asset(
                  AssetsHelper.healthCarePng,
                ),
              ),
        
              Container(
                width: double.infinity,
                height: screenHeight * 0.6,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFCFC),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.sp),
                    topRight: Radius.circular(25.sp),
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      Text(
                        'Te damos la bienvenida',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      UserInput(
                        controller: userController,
                      ),
                      SizedBox(height: 20.h,),
                      PasswordInput(
                        controller: passwordController,
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        padding: EdgeInsets.only(
                          right: 10.w,
                        ),
                        width: double.infinity,
                        child: const Text(
                          'Olvidé mi contraseña',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      LoginButton(
                        enabled: passwordController.text != "" && userController.text != "",
                      ),
                      SizedBox(height: 20.h,),
                      const SignUpText(),
                    ],
                  ),
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}
