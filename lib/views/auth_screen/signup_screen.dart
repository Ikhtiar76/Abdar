import 'package:abdar/controllers/auth_controller.dart';
import 'package:abdar/views/home/home.dart';
import 'package:get/get.dart';
import '../../const/consts.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/my_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: semiBlackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    icSplashBg,
                    width: 130,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  'Sign Up!'
                      .text
                      .color(colorC)
                      .fontFamily(bold)
                      .size(40)
                      .make(),
                  'Welcome. Please enter your credentials!'
                      .text
                      .fontFamily(semibold)
                      .color(Colors.white)
                      .size(20)
                      .make(),
                  Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Obx(()=>
                         Column(
                          children: [
                            customTextField(
                              isPass: false,
                                title: name,
                                hint: nameHint,
                                controller: nameController,
                                prefixIcon: const Icon(Icons.person)),
                            customTextField(
                                isPass: false,
                                prefixIcon: const Icon(
                                  Icons.email,
                                ),
                                title: email,
                                hint: emailhint,
                                controller: emailController),
                            customTextField(
                                isPass: true,
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                                title: password,
                                hint: passwordhint,
                                controller: passwordController),
                            customTextField(
                                isPass: true,
                                prefixIcon: const Icon(
                                  Icons.lock_reset_sharp,
                                  size: 20,
                                ),
                                title: retypePass,
                                hint: retypePassHint,
                                controller: passwordRetypeController),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Checkbox(
                                    side: BorderSide(color: colorC),
                                    activeColor: colorC,
                                    checkColor: color1,
                                    value: isCheck,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isCheck = newValue;
                                      });
                                    }),
                                Expanded(
                                  child: RichText(
                                      text: const TextSpan(children: [
                                    TextSpan(
                                        text: 'I agree to the ',
                                        style: TextStyle(
                                            fontFamily: regular,
                                            color: Colors.white)),
                                    TextSpan(
                                        text: termsCond,
                                        style: TextStyle(
                                            fontFamily: bold, color: colorA)),
                                    TextSpan(
                                        text: " & ",
                                        style: TextStyle(
                                            fontFamily: bold,
                                            color: Colors.white)),
                                    TextSpan(
                                        text: privacPolicy,
                                        style: TextStyle(
                                            fontFamily: bold, color: colorA))
                                  ])),
                                )
                              ],
                            ),
                            15.heightBox,
                            controller.isLoading.value?CircularProgressIndicator():
                            MyButton(
                                    title: Signup,
                                    color: isCheck == true ? colorC : color1,
                                    textColor: isCheck == true
                                        ? semiBlackColor
                                        : Colors.white12,
                                    onPressed: ()async{
                                      controller.isLoading(true);
                                      if(isCheck !=false){
                                        try{
                                          await controller.signupMethod(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ).then((value) {
                                            return controller.storeDataMethod(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                            );
                                          }).then((value){
                                            VxToast.show(context, msg: loggedIn);
                                            Get.offAll(()=>const Home());
                                          });
                                        }catch(e){
                                          auth.signOut();
                                          VxToast.show(context, msg: e.toString());
                                          controller.isLoading(false);
                                        }
                                      }
                                    }
                            )
                                .box
                                .width(context.screenWidth)
                                .make(),
                            15.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                'Already have an account? '
                                    .text
                                    .fontFamily(regular)
                                    .color(Colors.white)
                                    .make(),
                                login.text
                                    .fontFamily(bold)
                                    .size(20)
                                    .color(colorC)
                                    .make()
                                    .onTap(() {
                                  Get.back();
                                })
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
