import 'package:birdz_app/consts/firebase_consts.dart';
import 'package:birdz_app/controller/profile_controller.dart';
import 'package:birdz_app/edit_profile_screen.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'consts/lists.dart';
import 'controller/auth_controller.dart';
import 'main.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    // var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Profile",
          style: TextStyle(color: Colors.grey.shade700),
        )),
        backgroundColor: Colors.white,
      ),
      // backgroundColor: Colors.green.shade50,
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  data['imageUrl'] == ''
                                      ? Image.asset(cockatiel,
                                              width: 145,
                                              height: 145,
                                              fit: BoxFit.cover)
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make()
                                      : Image.network(data['imageUrl'],
                                              width: 145,
                                              height: 145,
                                              fit: BoxFit.cover)
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make(),
                                  Positioned(
                                    right: -1,
                                    bottom: 0,
                                    child: SizedBox(
                                      height: 55,
                                      width: 55,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white)),
                                        child: Center(
                                            child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.grey.shade500)),
                                        onPressed: () {
                                          controller.nameeController.text =
                                              data['name'];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfileScreen(
                                                        data: data,
                                                      )));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 100,left: 20),
                                child: Text("${data['name']}",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xFF4E343E)),),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        // const SizedBox(
                        //   height: 50,
                        // ),

                        // ListView.separated(
                        //   shrinkWrap: true,
                        //   separatorBuilder: (context,index){
                        //     return Divider(color: Colors.black,);
                        //   },
                        //   itemCount: profileIconList.length,
                        //   itemBuilder: (BuildContext context, int index){
                        //     return ListTile(
                        //       leading: Image.asset(profileIconList[index],width: 30,),
                        //       title: profileTxtList[index],
                        //       trailing: endingIcons,
                        //     );
                        //   },
                        //
                        // ).box.color(Colors.grey.shade200).rounded.padding(const EdgeInsets.symmetric(horizontal: 26)).shadowSm.make(),
                        // const SizedBox(height: 50,),
                        // SizedBox(
                        //   width: 150,
                        //   height: 40,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.green.shade300,
                        //     ),
                        //     onPressed: () async {
                        //       await Get.put(AuthController()).signoutMethod(context);
                        //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        //       controller.isLoading(false);
                        //     },
                        //     child: Row(
                        //       children: [
                        //         Icon(Icons.logout_outlined,size: 30,),
                        //         SizedBox(width: 10,),
                        //         const Text('Logout',style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 20,
                        //         ),),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Column(
                          children: [
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: ElevatedButton(

                                onPressed: () {},
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                              ),
                                child: SizedBox(
                                height: 70,
                                child: Row(
                                  children: [
                                    Icon(Icons.person_outline,color: Colors.grey.shade600,size: 40,),
                                    const SizedBox(width: 20,),
                                    Expanded(child: Text("My Account",style: TextStyle(color: Colors.grey.shade600,fontSize: 22,fontWeight: FontWeight.w400))),
                                    const SizedBox(width: 20,),
                                    const Icon(Icons.chevron_right,color: Colors.black,size: 35,),

                                  ],
                                ),
                              ),
                                ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Column(
                          children: [
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: ElevatedButton(

                                onPressed: () {},
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                                ),
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Icon(Icons.notification_add,color: Colors.grey.shade600,size: 40,),
                                      const SizedBox(width: 20,),
                                      Expanded(child: Text("Notifications",style: TextStyle(color: Colors.grey.shade600,fontSize: 22,fontWeight: FontWeight.w400))),
                                      const SizedBox(width: 20,),
                                      const Icon(Icons.chevron_right,color: Colors.black,size: 35,),

                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: ElevatedButton(

                                onPressed: () {},
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                                ),
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Icon(Icons.settings,color: Colors.grey.shade600,size: 40,),
                                      const SizedBox(width: 20,),
                                      Expanded(child: Text("Settings",style: TextStyle(color: Colors.grey.shade600,fontSize: 22,fontWeight: FontWeight.w400))),
                                      const SizedBox(width: 20,),
                                      const Icon(Icons.chevron_right,color: Colors.black,size: 35,),

                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: ElevatedButton(

                                onPressed: () {},
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                                ),
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Icon(Icons.help,color: Colors.grey.shade600,size: 40,),
                                      const SizedBox(width: 20,),
                                      Expanded(child: Text("Help Centre",style: TextStyle(color: Colors.grey.shade600,fontSize: 22,fontWeight: FontWeight.w400))),
                                      const SizedBox(width: 20,),
                                      const Icon(Icons.chevron_right,color: Colors.black,size: 35,),

                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        //       child: ElevatedButton(
                        //         onPressed: () async {
                        //           await Get.put(AuthController()).signoutMethod(context);
                        //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        //           controller.isLoading(false);
                        //           },
                        //         style: ButtonStyle(
                        //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        //               const RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(15)),
                        //               ),
                        //             ),
                        //             backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                        //         ),
                        //         child: SizedBox(
                        //           height: 70,
                        //           child: Row(
                        //             children: [
                        //               Icon(Icons.logout_outlined,color: Colors.grey.shade600,size: 40,),
                        //               SizedBox(width: 20,),
                        //               Expanded(child: Text("Logout",style: TextStyle(color: Colors.grey.shade600,fontSize: 22,fontWeight: FontWeight.w400))),
                        //               SizedBox(width: 20,),
                        //               Icon(Icons.chevron_right,color: Colors.black,size: 35,),
                        //
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        const SizedBox(height: 40,),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade300,
                            ),
                            onPressed: () async {
                              await Get.put(AuthController()).signoutMethod(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                              controller.isLoading(false);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.logout_outlined,size: 30,),
                                SizedBox(width: 10,),
                                Text('Logout',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),),
                              ],
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
