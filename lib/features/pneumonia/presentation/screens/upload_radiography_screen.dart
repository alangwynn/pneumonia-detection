// ignore_for_file: depend_on_referenced_packages
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:pneumonia_detection/common/toast.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/providers/state/scan_image.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/screens/screens.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/widgets/widgets.dart';

class UploadRadiographyScreen extends ConsumerStatefulWidget {
  const UploadRadiographyScreen({super.key});

  static const routeName = '/upload-image-screen';

  @override
  ConsumerState<UploadRadiographyScreen> createState() =>
      _UploadRadiographyScreenState();
}

class _UploadRadiographyScreenState
    extends ConsumerState<UploadRadiographyScreen> {
  File? _image;

  final picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar de la galería'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Tomar una foto'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(scanPneumoniaImageProvider, (previous, next) {
      if (next.isLoading) {
        context.loaderOverlay.show();
      } else if (next.hasError) {
        context.loaderOverlay.hide();
        ToastOverlay.showToastMessage(
          'Ocurrió un error al escanear la imagen',
          ToastType.error,
          context,
        );
      } else if (next.hasValue) {
        context.loaderOverlay.hide();
        GoRouter.of(context).go(PneumoniaDetecionDetailsScreen.routeName);
        ToastOverlay.showToastMessage(
          'Imagen escaneada correctamente',
          ToastType.success,
          context
        );
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Cargar Radiografía Torácica',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: UploadButton(
            enabled: _image == null ? false : true,
            text: 'Escanear',
            documento: '',
            // image: _image!,
            onPressed: ref.read(scanPneumoniaImageProvider.notifier).scanImagen,
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
                  'Cargue la radiografía',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: showOptions,
                child: _image == null
                    ? Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: const DashedBorder.fromBorderSide(
                              dashLength: 15,
                              side: BorderSide(color: Colors.blue, width: 2)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Selecciona una imagen',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    : Image.file(_image!,
                        width: double.infinity, height: 200, fit: BoxFit.cover),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
