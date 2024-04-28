import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:automarket/Model/GetX/Binding/initial_binding.dart';
import 'package:automarket/Model/GetX/Controller/duplicate_controller.dart';
import 'package:automarket/View/ProfileScreen/AuthenticationScreen/authentication_screen.dart';
import 'package:automarket/View/RootScreen/root.dart';

import 'package:automarket/ViewModel/Initial/initial.dart';
import 'package:get/get.dart';

void main() async {
  /**Inicializar todo antes de iniciar */
  WidgetsFlutterBinding.ensureInitialized();

  /**Verificar informacion de firebase para inicializar firebase*/
  await HighPriorityInitial.initial();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*bool isFirst = Get.find<DuplicateController>().introFunctions.getLaunchStatus();*/
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      title: 'automarket',
      home: const AuthenticationScreen(),
    );
  }
}
