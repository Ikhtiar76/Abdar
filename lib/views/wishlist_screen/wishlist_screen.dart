import 'package:abdar/const/consts.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: semiBlackColor,
      appBar: AppBar(
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
        title: 'My Wishlist'.text.fontFamily(bold).color(colorA).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 'No orders yet!'.text.color(colorA).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: colorB,
                        leading: Image.network(
                          '${data[index]['p_imgs'][0]}',
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        title: "${data[index]['p_name']}"
                            .text
                            .size(16)
                            .fontFamily(semibold)
                            .color(Colors.white)
                            .make(),
                        subtitle: "${data[index]['p_price']}"
                            .numCurrency
                            .text
                            .color(colorC)
                            .fontFamily(bold)
                            .make(),
                        trailing: IconButton(
                          onPressed: () async {
                            await fireStore
                                .collection(productsCollection)
                                .doc(data[index].id)
                                .set({
                              'p_wishlist':
                                  FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
