import 'package:abdar/const/consts.dart';
import 'package:abdar/views/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(const Duration(seconds: 5), () {
      //Get.to(()=>const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if(user==null && mounted){
          Get.to(()=>const LoginScreen());
        }else{
          Get.to(()=>const Home());
        }
      });
    },);
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icappLogo,width: 100,),
                Column(
                  children: [
                    appname.text.fontFamily(anton).size(60).color(color1).make(),
                    appversion.text.fontFamily(semibold).color(color1).make(),

                  ],
                )
              ],
            ),
            const SizedBox(height: 15,),
            const CircularProgressIndicator(
              strokeWidth: 5,
              color: appIcon,
            ),
          ],
        ),
      ),
    );
  }
}
