import 'package:abdar/const/consts.dart';
import 'package:abdar/controllers/product_controller.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/views/categories_screen/item_details.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;

  const CategoryDetails({Key? key, this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    }else{
      productMethod = FirestoreServices.getProducts(title);
    }
  }


  var controller = Get.find<ProductController>();
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: semiBlackColor,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          backgroundColor: colorB,
          automaticallyImplyLeading: false,
          leading: const Icon(
            Icons.arrow_back,
            color: colorA,
          ).onTap(() {
            Get.back();
          }),
          elevation: 0,
          title: widget.title!.text.color(colorA).bold.make(),
        ),
        body: Column(
          children: [
            10.heightBox,
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    controller.subcat.length,
                        (index) => "${controller.subcat[index]}"
                        .text
                        .color(Colors.white)
                        .makeCentered()
                        .box
                        .margin(const EdgeInsets.all(4))
                        .roundedSM
                        .width(120)
                        .height(40)
                        .color(colorB)
                        .make().onTap(() { 
                          switchCategory("${controller.subcat[index]}");
                          setState(() {});
                        })),
              ),
            ),
            15.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: 'No products found!'.text.color(colorA).makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;

                  return
                      Expanded(
                          child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                mainAxisExtent: 280),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(data[index]['p_imgs'][0],height: 150,
                                  width: 200, fit: BoxFit.cover),
                              30.heightBox,
                              '${data[index]['p_name']}'
                                  .text
                                  .color(color4)
                                  .semiBold
                                  .make(),
                              10.heightBox,
                              '${data[index]['p_price']}'
                                  .numCurrency
                                  .text
                                  .color(color1)
                                  .bold
                                  .make()
                            ],
                          )
                              .box
                              .rounded
                              .outerShadowSm
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .color(Colors.white)
                              .make()
                              .onTap(() {
                                controller.checkIfFav(data[index]);
                            Get.to(() => ItemDetails(
                                title: '${data[index]['p_name']}',
                                data: data[index]));
                          });
                        },
                      ));
                }
              },
            ),
          ],
        ));
  }
}
