import 'package:abdar/const/consts.dart';
import 'package:abdar/controllers/cart_controller.dart';
import 'package:abdar/views/cart_screen/payment_method.dart';
import 'package:abdar/widgets/custom_textfield.dart';
import 'package:abdar/widgets/my_button.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: semiBlackColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: colorA,),
          onPressed: (){
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
        title: 'Shopping Info'.text.fontFamily(bold).color(colorA).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: MyButton(
          onPressed: (){
            if(controller.addressController.text.length>10){
              Get.to(()=>const PaymentMethod());
            }else{
              VxToast.show(context, msg: 'Please fill the form');
            }
          },
          color: colorC,
          textColor: Colors.white,
          title: 'Continue'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(isPass: false,title: "Address",hint: "Address",controller: controller.addressController),
            customTextField(isPass: false,title: "City",hint: "City",controller: controller.cityController),
            customTextField(isPass: false,title: "State",hint: "State",controller: controller.stateController),
            customTextField(isPass: false,title: "Postal code",hint: "Postal code",controller: controller.postalCodeController),
            customTextField(isPass: false,title: "Phone",hint: "Phone",controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}

