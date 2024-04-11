import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadButton extends StatefulWidget {

  const UploadButton({
    Key? key,
    this.enabled = false,
    required this.text,
    required this.onPressed,
    required this.documento,
    required this.image,
  }) : super(key: key);

  final bool enabled;
  final String text;
  final String documento;
  final File image;
  final void Function({
    required String documento,
    required String image,
  }) onPressed;

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.enabled ? () {
          widget.onPressed(
            documento: 'documento',
            image: 'imagen',
          );
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 15.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 16.sp,
            color: widget.enabled ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
