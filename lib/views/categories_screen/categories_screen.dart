import 'package:abdar/const/consts.dart';
import 'package:abdar/const/lists.dart';
import 'package:abdar/controllers/product_controller.dart';
import 'package:abdar/views/categories_screen/category_details.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: semiBlackColor,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
        ),
        backgroundColor: colorB,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,

        title: 'Categories'.text.color(Colors.white).bold.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 8),
        child:GridView.builder(
          shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 220,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(categoriesListImages[index],fit: BoxFit.cover,height: 140,width: 180),
                  categoriesList[index].text.semiBold.color(color4).align(TextAlign.center).make()
                ],
              ).box.rounded.clip(Clip.antiAlias).color(Colors.white).make().onTap(() {
                controller.getSubcategories(categoriesList[index]);
                Get.to(()=>  CategoryDetails(title: categoriesList[index],));
              });
            },),
      ),
    );
  }
}

