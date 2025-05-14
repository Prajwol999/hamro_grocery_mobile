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
    
    
    super.initState();
    fireOpenApp();
  }
  void fireOpenApp() async{

    await Future.delayed(const Duration(seconds:3));
    startApp();

  }
  void startApp(){
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=> const WelcomeView()),(route)=> false);

  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.primary,
      body:Center(
        child:
        Image.asset("assets/hamrologo.png",width:media.width *0.7)
      ),
      

    );
  }
}
