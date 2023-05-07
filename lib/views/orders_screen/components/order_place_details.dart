import 'package:abdar/const/consts.dart';

Widget orderPlaceDetails({title1,title2,d1,d2}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '$title1'.text.color(colorA).make(),
            5.heightBox,
            '$d1'.text.color(colorC).fontFamily(bold).make()
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              '$title2'.text.color(Colors.white).make(),
              5.heightBox,
              '$d2'.text.color(colorA).fontFamily(bold).make()
            ],
          ),
        )
      ],
    ),
  );
}
