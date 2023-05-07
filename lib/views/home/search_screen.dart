import 'package:abdar/const/consts.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/views/categories_screen/item_details.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: semiBlackColor,
      appBar: AppBar(
        title: title!.text.fontFamily(bold).color(colorA).make(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: colorA,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
        backgroundColor: colorB,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return 'No products found'.text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filterData=data
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, mainAxisExtent: 250),
                children: filterData
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filterData[index]['p_imgs'][0],
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            '${filterData[index]['p_name']}'
                                .text
                                .semiBold
                                .color(colorA)
                                .make(),
                            10.heightBox,
                            '${filterData[index]['p_price']}'
                                .numCurrency
                                .text
                                .semiBold
                                .color(colorC)
                                .make()
                          ],
                        )
                            .box
                            .color(colorB)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .padding(const EdgeInsets.all(12))
                            .roundedSM
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                                title: '${filterData[index]['p_name']}',
                                data: filterData[index],
                              ));
                        }))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
