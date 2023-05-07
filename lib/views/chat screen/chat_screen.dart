import 'package:abdar/const/consts.dart';
import 'package:abdar/controllers/chats_controller.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/views/chat%20screen/component/sender_bubble.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: semiBlackColor,
      appBar: AppBar(
        backgroundColor: colorB,
        automaticallyImplyLeading: false,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        title: 'ChatBox'.text.fontFamily(bold).color(colorA).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  :Expanded(
                      child: StreamBuilder(
                        stream: FirestoreServices.getMessages(
                            controller.chatDocId.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: 'Send a message...'
                                  .text
                                  .fontFamily(semibold)
                                  .color(colorC)
                                  .make(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs.mapIndexed((currentValue, index){

                                var data = snapshot.data!.docs[index];

                                return Align(
                                    alignment: data['uid'] == currentUser!.uid? Alignment.centerRight : Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList()
                            );
                          }
                        },
                      ),
                    ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                        controller: controller.msgController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: "Type a message.....",
                          labelStyle: TextStyle(color: colorA),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorA)),
                        ))),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: colorC,
                    ))
              ],
            )
                .box
                .height(70)
                .color(semiBlackColor)
                .margin(const EdgeInsets.only(left: 15, bottom: 8))
                .padding(const EdgeInsets.all(12))
                .make()
          ],
        ),
      ),
    );
  }
}
