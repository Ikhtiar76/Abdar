import 'package:abdar/const/consts.dart';
import 'package:abdar/widgets/my_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context){
  return Dialog(
    backgroundColor: colorB,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Confirm'.text.color(colorC).bold.size(20).make(),
        5.heightBox,
        'Are you sure you want to exit'.text.color(Colors.white).semiBold.size(15).make(),
        30.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyButton(
              title: 'Yes',
              textColor: Colors.white,
              color: colorC,
              onPressed: (){
                SystemNavigator.pop();
              }
            ),
            MyButton(
                title: 'No',
                textColor: Colors.white,
              color: colorC,
                onPressed: (){
                  Navigator.pop(context);
                }
            ),
          ],
        )
      ],
    ).box.padding(EdgeInsets.all(16)).make(),
  );
}
