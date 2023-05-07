import 'package:abdar/const/consts.dart';
import 'package:abdar/services/firestore_services.dart';
import 'package:abdar/views/chat%20screen/chat_screen.dart';
import 'package:abdar/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

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
        title: 'My Messages'.text.fontFamily(bold).color(colorA).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return 'No messages yet!'.text.color(colorA).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: colorB,
                        child: ListTile(
                          onTap: () {
                            Get.to(()=>const ChatScreen(),
                                arguments:[
                                  data[index]['friendName'],
                                  data[index]['toId'],
                                ] );
                          },
                          leading: const CircleAvatar(
                            backgroundColor: colorA,
                            child: Icon(
                              Icons.person,color: Colors.white,
                            ),
                          ),
                          title: "${data[index]['friendName']}".text.fontFamily(semibold).color(colorA).make(),
                          subtitle: "${data[index]['last_msg']}".text.color(Colors.white).make(),
                        ),
                      );
                    },))
              ],
            );
          }
        },
      ),
    );
  }
}

