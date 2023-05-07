import 'package:abdar/const/consts.dart';

Widget homeButton({String? title, icon, width, height, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 26,),
      10.heightBox,
      title!.text.fontFamily(semibold).color(Colors.white).make()
    ],
  ).box.rounded.size(width, height).shadowSm.color(colorB).make();
}
