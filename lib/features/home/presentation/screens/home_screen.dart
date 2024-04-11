import 'package:flutter/material.dart';
import 'package:pneumonia_detection/features/home/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home-screen'; 

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Health care App'),
        ),
        body: Container(),
        drawer: SideMenu(scaffoldKey: scaffoldKey,)
      ),
    );
  }
}
