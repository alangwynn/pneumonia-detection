import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pneumonia_detection/common/toast.dart';
import 'package:pneumonia_detection/features/login/presentation/providers/state/sign_up_user.dart';
import 'package:pneumonia_detection/features/login/presentation/screens/screens.dart';
import 'package:pneumonia_detection/features/login/presentation/widgets/widgets.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up-screen'; 

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();

  final nombreController = TextEditingController();

  final apellidoController = TextEditingController();

  final documentoController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool equals = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {setState(() {});});
    nombreController.addListener(() {setState(() {});});
    apellidoController.addListener(() {setState(() {});});
    documentoController.addListener(() {setState(() {});});
    passwordController.addListener(() {
      setState(() {
        
      });
    });
    confirmPasswordController.addListener(() {
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(signUpUserProvider, (previous, next) {
      if (next.isLoading) {
        context.loaderOverlay.show();
      } else if (next.hasError) {
        context.loaderOverlay.hide();
        ToastOverlay.showToastMessage(
          next.error.toString(),
          ToastType.error,
          context,
        );
      } else if (next.hasValue) {
        context.loaderOverlay.hide();
        ToastOverlay.showToastMessage(
          next.value!.mensaje,
          ToastType.success,
          context,
        );
        GoRouter.of(context).go(LoginScreen.routeName);
      }
    });

    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: emailController.text.isEmpty
            || nombreController.text.isEmpty
            || apellidoController.text.isEmpty
            || documentoController.text.isEmpty
            || passwordController.text.isEmpty
            || confirmPasswordController.text.isEmpty
            || (passwordController.text != confirmPasswordController.text)
              ? null
              : () {
                if (passwordController.text != confirmPasswordController.text) {
                  ToastOverlay.showToastMessage(
                    'Las contraseñas no coinciden',
                    ToastType.error,
                    context,
                  );
                  return;
                }
                ref.read(signUpUserProvider.notifier).signUpUser(
                  email: emailController.text,
                  nombre: nombreController.text,
                  apellido: apellidoController.text,
                  documento: documentoController.text,
                  password: passwordController.text
                );
              },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 15.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp),
              ),
            ),
            child: Text(
              'Registrar',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            children: [
              Text(
                'Registrarse',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                'Ingrese los datos solicitados para el registrar su cuenta',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(height: 10.h,),
              UserDataInput(
                controller: documentoController,
                hintText: 'Documento',
                icon: Icons.aspect_ratio
              ),
              SizedBox(height: 20.h,),
              UserDataInput(
                controller: nombreController,
                hintText: 'Nombre',
                icon: Icons.person
              ),
              SizedBox(height: 20.h,),
              UserDataInput(
                controller: apellidoController,
                hintText: 'Apellido',
                icon: Icons.person
              ),
              SizedBox(height: 20.h,),
              UserDataInput(
                controller: emailController,
                hintText: 'Correo electrónico',
                icon: Icons.email
              ),
              SizedBox(height: 20.h,),
              UserDataInput(
                controller: passwordController,
                hintText: 'Contraseña',
                icon: Icons.lock
              ),
              SizedBox(height: 20.h,),
              UserDataInput(
                controller: confirmPasswordController,
                hintText: 'Confirmar contraseña',
                icon: Icons.lock
              ),
            ],
          ),
        ),
      ),
    );
  }
}
