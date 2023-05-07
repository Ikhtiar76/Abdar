import 'package:abdar/const/consts.dart';
import 'package:abdar/views/orders_screen/components/order_place_details.dart';
import 'package:abdar/views/orders_screen/components/order_status.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({Key? key, required this.data}) : super(key: key);

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
        title: 'Order details'.text.fontFamily(bold).color(colorA).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
                color: Colors.green,
                title: 'Placed',
                icon: Icons.done,
                showDone: data['order_placed']),
            orderStatus(
                color: Colors.blue,
                title: 'Confirmed',
                icon: Icons.thumb_up,
                showDone: data['order_confirmed']),
            orderStatus(
                color: golden,
                title: 'on Delivery',
                icon: Icons.delivery_dining,
                showDone: data['order_on_delivery']),
            orderStatus(
                color: Colors.purple,
                title: 'Delivered',
                icon: Icons.done_all,
                showDone: data['order_delivered']),
            const Divider(),
            Column(
              children: [
                orderPlaceDetails(
                    title1: 'Order Code',
                    title2: 'Shipping Method',
                    d1: data['order_code'],
                    d2: data['shipping_method']),
                orderPlaceDetails(
                    title1: 'Order Date',
                    title2: 'Payment Method',
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    d2: data['payment_method']),
                orderPlaceDetails(
                    title1: 'Delivery Status',
                    title2: 'Payment Status',
                    d1: 'Unpaid',
                    d2: 'Order Placed'),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address"
                              .text
                              .size(20)
                              .fontFamily(bold)
                              .color(colorA)
                              .make(),
                          "${data['order_by_name']}"
                              .text
                              .color(Colors.white)
                              .make(),
                          "${data['order_by_email']}"
                              .text
                              .color(Colors.white)
                              .make(),
                          "${data['order_by_address']}"
                              .text
                              .color(Colors.white)
                              .make(),
                          "${data['order_by_city']}"
                              .text
                              .color(Colors.white)
                              .make(),
                          "${data['order_by_state']}"
                              .text
                              .color(Colors.white)
                              .make(),
                          "${data['order_by_phone']}"
                              .text
                              .color(Colors.white)
                              .make(),
                          "${data['order_by_postalcode']}"
                              .text
                              .color(Colors.white)
                              .make(),
                        ],
                      ),
                      Column(
                        children: [
                          "Total Amount"
                              .text
                              .size(20)
                              .fontFamily(bold)
                              .color(colorA)
                              .make(),
                          30.heightBox,
                          '${data['total_amount']}'
                          .numCurrency
                              .text
                              .color(colorC)
                              .fontFamily(bold)
                              .make()
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
                .box
                .roundedSM
                .shadowSm
                .color(colorB)
                .margin(const EdgeInsets.all(8))
                .make(),
            'Order Product'.text.color(colorA).fontFamily(bold).size(20).make(),
            10.heightBox,
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                        d1: "${data['orders'][index]['qty']}x",
                        d2: 'Refundable'),
                    Container(
                      margin: const EdgeInsets.only(left: 16, bottom: 10),
                      width: 30,
                      height: 10,
                      color: Color(data['orders'][index]['color']),
                    )
                  ],
                );
              }).toList(),
            )
                .box
                .roundedSM
                .shadowSm
                .color(colorB)
                .margin(const EdgeInsets.all(8))
                .make(),
            20.heightBox
          ],
        ),
      ),
    );
  }
}
