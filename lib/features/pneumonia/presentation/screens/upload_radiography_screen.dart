// ignore_for_file: depend_on_referenced_packages
import 'dart:io' as io;


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:pneumonia_detection/common/toast.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/providers/state/image_detail.dart';
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
  io.File? _image;

  final picker = ImagePicker();
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _image = io.File(croppedFile.path);
          ref.read(imageDetailProvider.notifier).setImage(_image!);
          ref.read(imageDetailProvider.notifier).setRadiography('torax');
        });
      }
    }
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
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Tomar una foto'),
                onTap: () {
                  _pickImage(ImageSource.camera);
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
            'Imagen escaneada correctamente', ToastType.success, context);
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
            enabled: _image == null || controller.text.isEmpty ? false : true,
            text: 'Escanear',
            documento: controller.text,
            image: _image != null ? _image! : io.File(''),
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
                          height: 250.h,
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
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 2.w
                              ),
                            ),
                            child: Image.file(
                              _image!,
                              width: double.infinity,
                              height: 250.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
              SizedBox(
                height: 20.h,
              ),
              DocumentoInput(
                controller: controller,
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
