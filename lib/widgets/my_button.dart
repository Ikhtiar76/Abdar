import 'package:abdar/const/consts.dart';

Widget MyButton({String? title, color, textColor, onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: const EdgeInsets.all(12),

    ),
      onPressed: onPressed,
      child: title!.text.color(textColor).size(20).fontFamily(bold).make(),
  );
}
