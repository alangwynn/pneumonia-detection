import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pneumonia_detection/features/home/presentation/screens/screens.dart';

class LoginButton extends StatefulWidget {
  final bool enabled;

  const LoginButton({Key? key, this.enabled = false}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.enabled ? () {
          GoRouter.of(context).go(HomeScreen.routeName);
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 15.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
        ),
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 16.sp,
            color: widget.enabled ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
