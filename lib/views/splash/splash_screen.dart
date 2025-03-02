import 'package:client_app/services/splash/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:client_app/core/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
        title: '',
        body: InkWell(
          onTap: (){
            // Navigator.pushNamed(context, RouteName.phoneNo);
            Navigator.of(context).pushNamed(RouteName.phoneNo);

          },
          child: Center(
            child: Text('Welcome to Splash Screen'),
          ),
        ),
        isDrawer: false,
        isResizeToAvoidBottomInset: false);
  }
}
