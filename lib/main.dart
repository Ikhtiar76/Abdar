import 'package:abdar/views/Splash_Screeen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'const/consts.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}


