// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pneumonia_detection/features/home/presentation/screens/screens.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/providers/state/image_detail.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/providers/state/scan_image.dart';

class PneumoniaDetecionDetailsScreen extends ConsumerWidget {
  const PneumoniaDetecionDetailsScreen({super.key});

  static const routeName = '/pneumonia-detection-details-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(
      scanPneumoniaImageProvider.select((value) => value.value!),
    );

    final scannedImage = ref.watch(
      imageDetailProvider.select((value) => value.file),
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go(HomeScreen.routeName);
          },
        ),
        title: Text(
          'Detalles de la radiografía',
          style: TextStyle(fontSize: 18.sp),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              GoRouter.of(context).go(HomeScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 15.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp),
              ),
            ),
            child: Text(
              'Volver',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                details.mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.sp),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.w),
                ),
                child: Image.file(
                  scannedImage,
                  width: double.infinity,
                  height: 250.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'El escaneo dió un ${details.porcentaje}%',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ),
    ));
  }
}
