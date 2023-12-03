import 'package:birdz_app/chats/chat_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({Key? key}) : super(key: key);

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  bool enableShimmer = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      enableShimmer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          "Chats",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        )),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || enableShimmer) {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma").format(t);
                        return Card(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade200,
                            highlightColor: Colors.grey.shade50,
                            enabled: enableShimmer,
                            child: ListTile(
                              onTap: () {
                                Get.to(
                                  () => const ChatScreen(),
                                  arguments: [
                                    data[index]['friend_name'],
                                    data[index]['to_Id']
                                  ],
                                );
                              },
                              leading: const CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              title: "${data[index]['friend_name']}"
                                  .text
                                  .fontWeight(FontWeight.bold)
                                  .make(),
                              subtitle:
                                  "${data[index]['last_msg']}".text.make(),
                              trailing: time.text.make(),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              "No messages yet!",
              style: TextStyle(color: Colors.grey.shade700),
            ));
          } else {
            var data = snapshot.data!.docs;
            enableShimmer = false;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma").format(t);
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(
                                () => const ChatScreen(),
                                arguments: [
                                  data[index]['friend_name'],
                                  data[index]['to_Id']
                                ],
                              );
                            },
                            leading: const CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            title: "${data[index]['friend_name']}"
                                .text
                                .fontWeight(FontWeight.bold)
                                .make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                            trailing: time.text.make(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
