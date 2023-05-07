import 'dart:io';

import 'package:abdar/const/consts.dart';
import 'package:abdar/controllers/profile_controller.dart';
import 'package:abdar/widgets/custom_textfield.dart';
import 'package:abdar/widgets/my_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: semiBlackColor,
      appBar: AppBar(
          backgroundColor: semiBlackColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: colorC)),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data img url and controller path is empty
              data['imgUrl']=='' && controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 80,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :

                  //if data img url is not empty but controller path is empty
              data['imgUrl']!='' && controller.profileImagePath.isEmpty?
                  Image.network(data['imgUrl'],width: 80,
                    fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make() :

                  // if both are empty
              Image.file(
                      File(controller.profileImagePath.value),
                      width: 80,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              SizedBox(
                height: 37,
                child: MyButton(
                  color: colorA,
                  title: 'Change',
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  textColor: Colors.white,
                ),
              ),
              const Divider(),
              20.heightBox,
              customTextField(
                  isPass: false,
                  title: name,
                  hint: nameHint,
                  controller: controller.nameController),
              10.heightBox,
              customTextField(
                  isPass: true,
                  title: oldPass,
                  hint: passwordhint,
                  controller: controller.oldPasswordController),
              10.heightBox,
              customTextField(
                  isPass: true,
                  title: newPass,
                  hint: passwordhint,
                  controller: controller.newPasswordController),
              20.heightBox,
              controller.isloading.value? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(colorC),
              ):
              SizedBox(
                height: 40,
                width: context.screenWidth - 40,
                child: MyButton(
                  color: colorC,
                  title: 'Save',
                  onPressed: () async{



                    controller.isloading(true);

                    //if img is not selected
                    if(controller.profileImagePath.value.isNotEmpty){
                      await controller.uploadProfileImage();
                    }else{
                      controller.profileImageLink = data['imgUrl'];
                    }

                    //if old pass matches data base
                    if(data['password'] == controller.oldPasswordController.text){

                      await controller.changeAuthPassword(
                        email: data['email'],
                        password: controller.oldPasswordController.text,
                        newpassword: controller.newPasswordController.text
                      );


                      await controller.updateProfile(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          password: controller.newPasswordController.text
                      );
                      VxToast.show(context, msg: 'Updated');
                    }else{
                      VxToast.show(context, msg: 'Wrong Old Password');
                      controller.isloading(false);
                    }



                  },
                  textColor: Colors.white,
                ),
              ),
            ],
          )
              .box
              .color(colorB)
              .rounded
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 25, left: 25, right: 25))
              .make(),
        ),
      ),
    );
  }
}
