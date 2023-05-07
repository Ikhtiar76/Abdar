import 'package:abdar/const/consts.dart';
import 'package:abdar/const/lists.dart';
import 'package:abdar/controllers/product_controller.dart';
import 'package:abdar/views/chat%20screen/chat_screen.dart';
import 'package:abdar/widgets/my_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  final dynamic data;

  const ItemDetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: semiBlackColor,
        appBar: AppBar(
          backgroundColor: colorB,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          title: title.text.bold.color(colorA).make(),
          automaticallyImplyLeading: false,
          leading:  IconButton(onPressed: (){
            controller.resetValues();
            Get.back();
          }, icon: const Icon(Icons.arrow_back,color: colorA,)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: colorA,
              ),
              onPressed: () {},
            ),
                  Obx(
                    ()=> IconButton(
                    icon:  Icon(
                      Icons.favorite,
                      color: controller.isFav.value? Colors.red:colorA,
                    ),
                    onPressed: () {
                      if(controller.isFav.value){
                        controller.removeFromWishlist(data.id,context);
                      }else{
                        controller.addToWishlist(data.id,context);
                      }
                    },
              ),
                  ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VxSwiper.builder(
                    viewportFraction: 1.0,
                    aspectRatio: 16 / 9,
                    height: 350,
                    itemCount: data["p_imgs"].length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        data["p_imgs"][index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ).box.make();
                    },
                  ),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title.text.color(Colors.white).semiBold.size(20).make(),
                        10.heightBox,
                        VxRating(
                          isSelectable: false,
                          value: double.parse(data["p_rating"]),
                          onRatingUpdate: (value) {},
                          size: 25,
                          normalColor: Colors.grey,
                          count: 5,
                          selectionColor: colorC,
                          maxRating: 5,
                        ),
                        10.heightBox,
                        '${data['p_price']}'.numCurrency
                            .text
                            .size(18)
                            .color(colorA)
                            .bold
                            .make(),
                        10.heightBox,
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                'Seller'.text.color(Colors.white).bold.make(),
                                5.heightBox,
                                '${data["p_seller"]}'
                                    .text
                                    .color(colorA)
                                    .fontFamily(regular)
                                    .make()
                              ],
                            )),
                            const CircleAvatar(
                              backgroundColor: semiBlackColor,
                              child: Icon(
                                Icons.message_rounded,
                                color: colorC,
                              ),
                            ).onTap(() {
                              Get.to(()=>ChatScreen(),
                                arguments: [data['p_seller'],data['vendor_id']],
                              );

                            })
                          ],
                        )
                            .box
                            .color(colorB)
                            .rounded
                            .margin(const EdgeInsets.only(right: 10))
                            .padding(const EdgeInsets.symmetric(horizontal: 10))
                            .height(70)
                            .make(),
                        20.heightBox,
                        Obx(()=>
                          Column(
                            children: [
                              Row(
                                   children: [
                                     'Color:'.text.color(Colors.white).bold.make(),
                                     20.widthBox,
                                     Row(
                                       children: List.generate(
                                           data["p_colors"].length,
                                           (index) => Stack(
                                                 alignment: Alignment.center,
                                                 children: [
                                                   VxBox()
                                                       .margin(const EdgeInsets.symmetric(
                                                           horizontal: 5))
                                                       .size(40, 40)
                                                       .roundedFull
                                                       .color(
                                                           Color(data['p_colors'][index])
                                                               .withOpacity(1.0))
                                                       .make().onTap(() {
                                                         controller.changeColorIndex(index);
                                                   }),
                                                    Visibility(
                                                     visible: index == controller.colorIndex.value,
                                                       child: const Icon(
                                                     Icons.done,
                                                     color: Colors.black,
                                                   ))
                                                 ],
                                               )),
                                     )
                                   ],
                                 )
                                     .box
                                     .margin(const EdgeInsets.only(right: 10))
                                     .color(semiBlackColor)
                                     .make(),
                              Row(
                                children: [
                                  'Quantity:'.text.color(Colors.white).bold.make(),
                                  20.widthBox,
                                  Obx(
                                    () => Row(children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(int.parse(data['p_price']));
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: colorC,
                                          )),
                                      controller.quantity.value.text
                                          .color(Colors.white)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(int.parse(data['p_price']));
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: colorC,
                                          )),
                                      10.widthBox,
                                      '(${data['p_quantity']} available)'
                                          .text
                                          .semiBold
                                          .color(colorA)
                                          .make()
                                    ]),
                                  ),
                                ],
                              )
                                  .box
                                  .color(semiBlackColor)
                                  .margin(const EdgeInsets.only(right: 10))
                                  .make(),
                              Row(
                                children: [
                                  2.widthBox,
                                  'Total:'.text.color(Colors.white).bold.make(),
                                  78.widthBox,
                                  '${controller.totalPrice.value}'.numCurrency.text.semiBold.color(colorC).make()
                                ],
                              )
                                  .box
                                  .color(semiBlackColor)
                                  .margin(const EdgeInsets.only(right: 10))
                                  .shadowMax
                                  .make(),
                            ],
                          ),
                        ),
                        20.heightBox,
                        'Description'
                            .text
                            .bold
                            .color(Colors.white)
                            .size(15)
                            .make(),
                        5.heightBox,
                        '${data['p_description']}'.text.color(colorA).make(),
                        10.heightBox,
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              itemDetailButtonList.length,
                              (index) => ListTile(
                                    title: itemDetailButtonList[index]
                                        .text
                                        .color(Colors.white)
                                        .semiBold
                                        .make(),
                                    trailing: const Icon(
                                      Icons.arrow_forward,
                                      color: colorA,
                                    ),
                                  )),
                        ),
                        10.heightBox,
                        productsYouMayLike.text.bold
                            .size(20)
                            .color(colorA)
                            .make(),
                        20.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(
                              6,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP1,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  10.heightBox,
                                  'Laptop 8/64gb'
                                      .text
                                      .semiBold
                                      .color(color4)
                                      .make(),
                                  10.heightBox,
                                  '\$600'.text.semiBold.color(color1).make()
                                ],
                              )
                                  .box
                                  .color(Colors.white)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(const EdgeInsets.all(8))
                                  .roundedSM
                                  .make(),
                            ),
                          ),
                        ),
                        10.heightBox
                      ],
                    ),
                  ),
                ],
              )),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: MyButton(
                  title: 'Add to cart',
                  color: colorC,
                  textColor: Colors.white,
                  onPressed: (){
                    if(controller.quantity.value > 0){
                      controller.addToCart(
                        color: data['p_colors'][controller.colorIndex.value],
                        context: context,
                        vendorID: data['vendor_id'],
                        qty: controller.quantity.value,
                        img: data['p_imgs'][0],
                        title: data['p_name'],
                        sellername: data["p_seller"],
                        tprice: controller.totalPrice.value,
                      );
                      VxToast.show(context, msg: 'Added to cart');
                    }
                    else{
                      VxToast.show(context, msg: 'Minimum 1 product is required');
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
