import 'package:abdar/const/consts.dart';

Widget DetailsCard({width, String ? count, String ? title}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(golden).size(17).make(),
      5.heightBox,
      title!.text.color(colorA).make()
    ],
  ).box.width(width).height(80).roundedSM.color(colorB).make();
}
