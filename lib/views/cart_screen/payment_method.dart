import 'package:abdar/const/consts.dart';
import 'package:abdar/const/lists.dart';
import 'package:abdar/controllers/cart_controller.dart';
import 'package:abdar/views/home/home.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:abdar/widgets/my_button.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: semiBlackColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: colorA,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
          backgroundColor: colorB,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          title: 'Choose payment method'
              .text
              .fontFamily(bold)
              .color(colorA)
              .make(),
        ),
        bottomNavigationBar: controller.placingOrder.value
            ? Center(
                child: loadingIndicator(),
              )
            : MyButton(
                onPressed: () async {
                  await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentMethods[controller.paymentIndex.value],
                      totalAmount: controller.totalP.value);
                  await controller.clearCart();
                  VxToast.show(context, msg: 'Order placed successfully');
                  
                  Get.offAll(const Home());
                },
                color: colorC,
                textColor: Colors.white,
                title: 'Place my order'),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? golden
                              : Colors.transparent,
                          width: 4,
                          style: BorderStyle.solid)),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Image.asset(
                        paymentMethodImg[index],
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                value: true,
                                onChanged: (value) {},
                              ),
                            )
                          : Container(),
                      Positioned(
                          right: 10,
                          bottom: 5,
                          child: paymentMethods[index]
                              .text
                              .color(Colors.white)
                              .fontFamily(semibold)
                              .size(15)
                              .make())
                    ],
                  ),
                ),
              );
            })),
          ),
        ),
      ),
    );
  }
}
