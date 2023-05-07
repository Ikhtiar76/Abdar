import 'package:abdar/const/consts.dart';
import 'package:abdar/controllers/auth_controller.dart';
import 'package:abdar/views/auth_screen/signup_screen.dart';
import 'package:abdar/views/home/home.dart';
import 'package:abdar/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import '../../const/lists.dart';
import '../../widgets/my_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: semiBlackColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  icSplashBg,
                  width: 180,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                'Login!'.text.color(colorC).fontFamily(bold).size(40).make(),
                'Good to see you again!'
                    .text
                    .fontFamily(semibold)
                    .color(colorA)
                    .size(20)
                    .make(),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Obx(()=>
                     Column(
                      children: [
                        customTextField(
                          controller: controller.emailController,
                          isPass: false,
                          title: email,
                          hint: emailhint
                        ),
                        customTextField(
                          controller: controller.passwordController,
                            isPass: true,
                          title: password,
                          hint: passwordhint
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child:
                                    forgetPass.text.color(colorA).make())),
                        10.heightBox,
                        controller.isLoading.value? const CircularProgressIndicator(
                          color: colorA,
                        ):
                        MyButton(
                          title: login,
                          color: colorC,
                          textColor: Colors.white,
                          onPressed: ()async{
                            controller.isLoading(true);
                            await controller.loginMethod(context: context).then((value){
                              if(value!=null){
                                VxToast.show(context, msg: loggedIn);
                                Get.offAll(()=>const Home());
                              }else{
                                controller.isLoading(false);
                              }
                            });

                          }
                        ).box.width(context.screenWidth).make(),
                        10.heightBox,
                        Createaccount.text.fontFamily(semibold).color(Colors.white).make(),
                        10.heightBox,
                        MyButton(
                          color: Colors.orange.shade100,
                          title: Signup,
                          textColor: colorB,
                          onPressed: (){
                            Get.to(()=>const SignUpScreen());
                          }
                        ).box.width(context.screenWidth -50).make(),
                        10.heightBox,
                        Loginwith.text.fontFamily(semibold).color(Colors.white).make(),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(3, (index) => CircleAvatar(
                            backgroundColor: semiBlackColor,
                            child: Image.asset(socialIconLists[index],
                            width: 30,
                            ),
                          )),
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
