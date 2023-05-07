import 'package:abdar/const/consts.dart';

Widget orderStatus({icon,color,title,showDone}){
  return ListTile(
    leading:  Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(colorA).make(),
          showDone? const Icon(Icons.done,color: Colors.red,):Container()
        ],
      ),
    ),
  );
}