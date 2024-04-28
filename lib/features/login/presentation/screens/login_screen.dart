
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pneumonia_detection/common/toast.dart';
import 'package:pneumonia_detection/features/home/presentation/screens/home_screen.dart';
import 'package:pneumonia_detection/features/login/presentation/providers/state/login_user.dart';
import 'package:pneumonia_detection/features/login/presentation/widgets/widgets.dart';
import 'package:pneumonia_detection/helpers/assets_helper.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  static const routeName = '/login-screen'; 

  final documentoController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final screenHeight = MediaQuery.of(context).size.height;

    ref.listen(userLoginProvider, (previous, next) {
      if (next.isLoading) {
        context.loaderOverlay.show();
      } else if (next.hasError) {
        context.loaderOverlay.hide();
        ToastOverlay.showToastMessage(
          'El usuario o contraseña no coincide con un usuario registrado',
          ToastType.error,
          context,
        );
      } else if (next.hasValue) {
        context.loaderOverlay.hide();
        GoRouter.of(context).go(HomeScreen.routeName);
      }
    });

    void login() {
      ref.read(userLoginProvider.notifier).login(
        documento: documentoController.text,
        password: passwordController.text
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

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
                        controller: documentoController,
                      ),
                      SizedBox(height: 20.h,),
                      PasswordInput(
                        controller: passwordController,
                      ),
                      SizedBox(height: 20.h,),
                      LoginButton(
                        onClick: login,
                        enabled: passwordController.text != "" && documentoController.text != "",
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
