import 'package:abdar/const/consts.dart';
import 'package:abdar/views/categories_screen/category_details.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.cover,
      ),
      10.widthBox,
      title!.text.color(Colors.white).semiBold.make()
    ],
  )
      .box
      .color(colorB)
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .outerShadowSm
      .roundedSM
      .make().onTap(() {
        Get.to(()=> CategoryDetails(title: title,));
  });
}
