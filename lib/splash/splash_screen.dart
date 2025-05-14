import 'package:flutter/material.dart';
import '../common/color_extension.dart'; 
import "package:hamro_grocery_mobile/splash/welcome_view.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO:implement initstate
    
    super.initState();
  }
  void fireOpenApp() async{

    await Future.delayed(const Duration(seconds:3));

  }
  void startApp(){
    Navigator.push(context, MaterialPageRoute(builder:(context)=> const WelcomeView()));

  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.primary,
      body:Stack(
        alignment: Alignment.center,
        children:[
        Image.asset("android/assets/image/splash_logo.png",width:media.width *0.7,fit:BoxFit.cover)
      ])
      

    );
  }
}
