import 'package:flutter/material.dart';
import '../../view_model/services/splash_services.dart';
import '../common_widget/soft_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices.isFirstTime(context: context);
    //context.read<HomeBloc>().add(GetFilesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularSoftButton(
              radius: 45,
              padding: 10,
              icon: Container(
                margin: const EdgeInsets.all(5),
                child: Center(
                  child: Icon(Icons.play_arrow_rounded,color: Colors.blue,size: 60,),
                ),
              ),
            ),
            Text('Music',style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),)
          ],
        ),
      ),
    );
  }
}
