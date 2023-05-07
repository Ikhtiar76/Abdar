import 'package:abdar/const/consts.dart';
import 'package:abdar/controllers/cart_controller.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/views/cart_screen/shipping_screen.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:abdar/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: semiBlackColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: MyButton(
              title: 'Proceed to shipping',
              textColor: Colors.white,
              color: colorC,
              onPressed: () {
                Get.to(()=>const ShippingDetails());
              }),
        ),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
          backgroundColor: colorB,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          title: 'Shopping Cart'.text.color(colorA).bold.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: 'Cart is Empty!'
                    .text
                    .color(colorA)
                    .fontFamily(bold)
                    .size(20)
                    .make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network('${data[index]['img']}',width: 80,fit:BoxFit.cover,),
                          title: "${data[index]['title']}  (x${data[index]['qty']})"
                              .text
                              .size(16)
                              .fontFamily(semibold)
                              .color(Colors.white)
                              .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .color(colorC)
                              .fontFamily(bold)
                              .make(),
                          trailing: IconButton(
                            onPressed: (){
                              FirestoreServices.deleteDocument(data[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: colorC,
                            ),
                          ),
                        );
                      },
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Total price'
                            .text
                            .size(15)
                            .color(Colors.white)
                            .fontFamily(semibold)
                            .make(),
                        Obx(() => '${controller.totalP.value}'
                            .numCurrency
                            .text
                            .size(15)
                            .color(colorC)
                            .fontFamily(bold)
                            .make()),
                      ],
                    )
                        .box
                        .rounded
                        .color(colorB)
                        .width(context.screenWidth - 60)
                        .padding(const EdgeInsets.all(8))
                        .make(),
                    10.heightBox,
                    // SizedBox(
                    //   width: context.screenWidth - 60,
                    //   child: MyButton(
                    //       title: 'Proceed to shipping',
                    //       textColor: Colors.white,
                    //       color: colorC,
                    //       onPressed: () {}),
                    // )
                  ],
                ),
              );
            }
          },
        ));
  }
}
