import 'package:abdar/const/consts.dart';
import 'package:abdar/const/lists.dart';
import 'package:abdar/controllers/home_controller.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/views/categories_screen/item_details.dart';
import 'package:abdar/views/home/components/featured_button.dart';
import 'package:abdar/views/home/search_screen.dart';
import 'package:abdar/widgets/home_buttons.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      color: semiBlackColor,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(top: 15),
            height: 60,
            alignment: Alignment.center,
            color: Colors.transparent,
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: controller.searchController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: colorA,
                ).onTap(() {
                  if(controller.searchController.text.isNotEmptyAndNotNull){
                    Get.to(()=>  SearchScreen(title: controller.searchController.text,));
                  }
                }),
                filled: true,
                fillColor: colorB,
                hintStyle: const TextStyle(
                  fontFamily: semibold,
                  fontSize: 15,
                  color: colorA,
                ),
                hintText: searchAnything,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  10.heightBox,
                  VxSwiper.builder(
                    viewportFraction: 1.0,
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 5),
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: swiperLists.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        swiperLists[index],
                        fit: BoxFit.cover,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButton(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todayDeal : flashSale)),
                  ),
                  10.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 150,
                    itemCount: secondswiperLists.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondswiperLists[index],
                        fit: BoxFit.cover,
                      )
                          .box
                          .roundedSM
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButton(
                            title: index == 0
                                ? topCategories
                                : index == 1
                                    ? brand
                                    : topSellers,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            height: context.screenHeight * 0.12,
                            width: context.screenWidth / 3.5)),
                  ),
                  20.heightBox,
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text.bold
                            .size(20)
                            .color(Colors.white)
                            .make()),
                  ),
                  20.heightBox,
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                      title: featuredTitle1[index],
                                      icon: featuredImages1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      title: featuredTitle2[index],
                                      icon: featuredImages2[index]),
                                ],
                              )),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: colorB,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.bold
                              .color(Colors.white)
                              .size(20)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,AsyncSnapshot <QuerySnapshot> snapshot) {
                                if(!snapshot.hasData){
                                  return Center(child: loadingIndicator());
                                }else if(snapshot.data!.docs.isEmpty){
                                  return 'No featured products'.text.semiBold.color(Colors.white).make();
                                }else{
                                  var featureData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featureData.length,
                                          (index) => Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featureData[index]['p_imgs'][0],
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          '${featureData[index]['p_name']}'
                                              .text
                                              .semiBold
                                              .color(color4)
                                              .make(),
                                          10.heightBox,
                                          '${featureData[index]['p_price']}'.numCurrency.text.semiBold.color(golden).make()
                                        ],
                                      )
                                          .box
                                          .color(Colors.white)
                                          .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                          .padding(const EdgeInsets.all(8))
                                          .roundedSM
                                          .make().onTap(() {
                                            Get.to(ItemDetails(title: '${featureData[index]['p_name']}',
                                              data: featureData[index],));
                                          }),
                                    ),
                                  );
                                }
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 150,
                    itemCount: secondswiperLists.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondswiperLists[index],
                        fit: BoxFit.cover,
                      )
                          .box
                          .roundedSM
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  20.heightBox,
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: 'All products'
                            .text
                            .color(Colors.white)
                            .fontFamily(bold)
                            .size(18)
                            .make()),
                  ),
                  20.heightBox,
                  StreamBuilder(
                    stream: FirestoreServices.allProduct(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return loadingIndicator();
                      } else {
                        var allProductsData = snapshot.data!.docs;
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allProductsData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  mainAxisExtent: 250),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  allProductsData[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                '${allProductsData[index]['p_name']}'
                                    .text
                                    .semiBold
                                    .color(colorA)
                                    .make(),
                                10.heightBox,
                                '${allProductsData[index]['p_price']}'.numCurrency
                                    .text
                                    .semiBold
                                    .color(colorC)
                                    .make()
                              ],
                            )
                                .box
                                .color(colorB)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .padding(const EdgeInsets.all(12))
                                .roundedSM
                                .make().onTap(() {
                                  Get.to(ItemDetails(title: '${allProductsData[index]['p_name']}',
                                    data: allProductsData[index],));
                            });
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
