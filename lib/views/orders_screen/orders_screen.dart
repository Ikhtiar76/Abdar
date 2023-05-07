import 'package:abdar/const/consts.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/views/orders_screen/orders_details.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

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
        title: 'My Orders'.text.fontFamily(bold).color(colorA).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return 'No orders yet!'.text.color(colorA).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context,int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ListTile(
                      leading: '${index+1}'.text.fontFamily(bold).color(colorA).xl.make(),
                      tileColor: colorB,
                      title: data[index]['order_code'].toString().text.fontFamily(semibold).color(Colors.white).make(),
                      subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).color(colorC).make(),
                      trailing: IconButton(
                        onPressed: (){
                          Get.to(()=>OrdersDetails(data: data[index]));
                        },
                        icon: const Icon(Icons.arrow_forward_ios,color: colorA,),
                      ),
                    ),
                  );
                },
            );
          }
        },
      ),
    );
  }
}

