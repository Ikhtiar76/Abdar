import 'package:abdar/const/consts.dart';
import 'package:abdar/const/lists.dart';
import 'package:abdar/controllers/auth_controller.dart';
import 'package:abdar/controllers/profile_controller.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/views/auth_screen/login_screen.dart';
import 'package:abdar/views/chat%20screen/messaging_screen.dart';
import 'package:abdar/views/orders_screen/orders_screen.dart';
import 'package:abdar/views/profile_screen/components/details_card.dart';
import 'package:abdar/views/profile_screen/edit.dart';
import 'package:abdar/views/wishlist_screen/wishlist_screen.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: semiBlackColor,
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(colorC),),
          );
        }else{

          var data = snapshot.data!.docs[0];

          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Align(alignment:Alignment.topRight,child: Icon(Icons.edit,color: golden,)).onTap(() {
                    controller.nameController.text =data['name'];
                    Get.to(()=> EditProfileScreen(data: data));
                  }),
                  Row(
                    children: [
                      data['imgUrl'] ==''?
                      Image.asset(imgProfile2,width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                      :Image.network(data['imgUrl'],width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}".text.fontFamily(bold).size(20).color(golden).make(),
                            "${data['email']}".text.fontFamily(regular).color(colorA).make(),
                          ],
                        ),
                      ),
                      OutlinedButton(onPressed: ()async{
                        await Get.put(AuthController()).signOut(context);
                        Get.offAll(()=>const LoginScreen());
                      },
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: colorA
                              )
                          ),
                          child: 'Log out'.text.color(golden).fontFamily(bold).make()
                      )
                    ],
                  ),
                  20.heightBox,
                  FutureBuilder(
                      future: FirestoreServices.getCounts(),
                      builder: (BuildContext context,AsyncSnapshot snapshot) {
                        if(!snapshot.hasData){
                          return Center(child: loadingIndicator());
                        }
                        else{
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DetailsCard(
                                  title: 'In your cart',
                                  count: countData[0].toString(),
                                  width: context.screenWidth/3.4
                              ),
                              DetailsCard(
                                  title: 'In your wishlist',
                                  count: countData[1].toString(),
                                  width: context.screenWidth/3.4
                              ),
                              DetailsCard(
                                  title: 'Your orders',
                                  count: countData[2].toString(),
                                  width: context.screenWidth/3.4
                              ),
                            ],
                          );
                        }
                      },),
                  20.heightBox,
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: (){
                            switch(index){
                              case 0:
                                Get.to(()=>const OrdersScreen());
                                break;
                              case 1:
                                Get.to(()=>const WishlistScreen());
                                break;
                              case 2:
                                Get.to(()=>const MessagesScreen());
                                break;
                            }
                          },
                          leading: Image.asset(profileButtonIcon[index],width: 30,color: colorA,),
                          title: profileButtonList[index].text.fontFamily(bold).color(Colors.white).make(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: golden,
                        );
                      },
                      itemCount: profileButtonList.length).box.padding(const EdgeInsets.all(16)).rounded.color(colorB).make()
                ],
              ),
            ),
          );
        }
      },)
    );
  }
}

