import 'package:birdz_app/chats/chat_screen.dart';
import 'package:birdz_app/consts/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const CategoryDetails({Key? key, required this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
var controller = Get.put(ctgProductCollection);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade400,
        title: Text(title!,style: const TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.share,)),
        ],
      ),
    body: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          itemCount: data['cp_imgs'].length,
                          // autoPlay: true,
                          height:200,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.9,
                          itemBuilder: (context,index) {
                            return Image.network(
                              data["cp_imgs"][index],
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            );
                          }),

                      const SizedBox(height: 20,),
                      Text(title!,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 23),),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text("Category: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          Text("${data['cp_category']}",style: TextStyle(color: Colors.grey.shade600),),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          const Text("Subcatergory: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          Text("${data['cp_subcategory']}",style: TextStyle(color: Colors.grey.shade600),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['cp_rating']),
                        onRatingUpdate: (value){},
                      normalColor: Vx.gray300,
                      selectionColor: const Color(0xffad9c03),
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      const SizedBox(height: 10,),
                      Text("Rs ""${data['cp_price']}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF3E2723)),),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Icon(Icons.location_on,size: 20,),
                          const SizedBox(width: 5,),
                          Text("${data['cp_location']}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Text("Description:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      const SizedBox(height: 8,),
                      Text("${data['cp_desc']}"),
                      const SizedBox(height: 80,),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data['cp_seller_name']}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF4E343E)),),
                                  const SizedBox(height: 15,),
                                  const Row(
                                    children: [
                                      Text("View Profile",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black),),
                                      SizedBox(width: 15,),
                                      Icon(Icons.arrow_circle_right_outlined,color: Colors.black,size: 15,),
                                    ],
                                  )
                                ],
                              )),
                          Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.greenAccent.shade100,
                                    child: const Icon(Icons.message_outlined,color: Color(0xFF4E343E),),
                                  ),
                                  const Text("SMS",style: TextStyle(fontSize: 10,color: Color(0xFF4E343E),fontWeight: FontWeight.bold),),
                                ],
                              ),
                              const SizedBox(width: 7,),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.greenAccent.shade100,
                                    child: const Icon(Icons.call,color: Color(0xFF4E343E),),
                                  ),
                                  const Text("Call",style: TextStyle(fontSize: 10,color: Color(0xFF4E343E),fontWeight: FontWeight.bold),),
                                ],
                              ),
                              const SizedBox(width: 7,),
                              InkWell(
                                onTap: (){
                                  Get.to(
                                      () => const ChatScreen(),
                                    arguments: [data['cp_seller_name'], data['vendor_id']],
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.greenAccent.shade100,
                                      child: const Icon(Icons.mark_email_read,color: Color(0xFF4E343E),),
                                    ),
                                    const Text("App Chat",style: TextStyle(fontSize: 10,color: Color(0xFF4E343E),fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ).box.rounded.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(Colors.green.shade50).make(),
                    ],
                  ),
                ),
              ))
        ],
      ),
    ),
    );
  }
}
