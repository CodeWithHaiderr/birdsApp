import 'package:birdz_app/components/sender_bubble.dart';
import 'package:birdz_app/consts/firebase_consts.dart';
import 'package:birdz_app/controller/chats_controller.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "${controller.friendName}",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  : Expanded(
                      child: StreamBuilder(
                      stream: FirestoreServices.getChatMessages(
                          controller.chatDocId.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              "Send a message",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          );
                        } else {
                          return ListView(
                            children: snapshot.data!.docs.mapIndexed((currentValue, index){
                              var data= snapshot.data!.docs[index];
                              return Align(
                                  alignment: data['uid']! == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                                  child: senderBubble(data));
                            }).toList(),
                          );
                        }
                      },
                    )),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    hintText: "Type a message",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Vx.gray600,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Vx.gray600,
                    )),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.red,
                    )),
              ],
            )
                .box
                .height(70)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 10))
                .make(),
          ],
        ),
      ),
    );
  }
}
