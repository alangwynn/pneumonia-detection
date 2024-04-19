import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatefulWidget {
  final bool enabled;
  final VoidCallback onClick;

  const LoginButton({
    Key? key,
    this.enabled = false,
    required this.onClick,
  }) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.enabled 
          ? widget.onClick
          : null,
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
