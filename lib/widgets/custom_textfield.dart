import 'package:abdar/const/consts.dart';

Widget customTextField({String? title, String? hint, prefixIcon, suffixIcon,controller,required bool  isPass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.size(20).color(Colors.white).fontFamily(semibold).make(),
      5.heightBox,
      TextFormField(style: TextStyle(color: Colors.white),
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: colorA)
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: const TextStyle(
            fontFamily: semibold,
            fontSize: 15,
            color: Colors.grey,
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: colorA)
          ),
          hintText: hint,
          isDense: true,
        ),
      ),
      10.heightBox
    ],
  );
}

