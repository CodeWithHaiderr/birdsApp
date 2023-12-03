



import 'package:birdz_app/medication_home.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'controller/birds_controller.dart';

class Medication extends StatefulWidget {
  const Medication({Key? key}) : super(key: key);

  @override
  State<Medication> createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  var getMedicationList = FirestoreServices.getMedicationList();
  var controller = Get.put(BirdsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade400,
        title: const Text('Diseases and Medication',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          FutureBuilder(
            future: getMedicationList,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child:  loadingIndicator(),
                );
              } else if(snapshot.data!.docs.isEmpty){
                return  const
                Expanded(
                  child: Center(
                    child: Text("Nothing found..",style: TextStyle(color: Vx.gray800),),
                  ),
                );
              }
              else{
                var data = snapshot.data!.docs;
                return Expanded(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 230,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 8,

                        ),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationHomeScreen(title: "${data[index]['Breed']}",data: data[index],)));
                            },
                            child: Column(
                              children: [
                                Image.network(data[index]['Imgs'],height: 170,width: 160,fit: BoxFit.cover,),
                                const SizedBox(height: 5,),
                                Center(
                                  child: Text("${data[index]['Breed']}",style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text("tap for more information",style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 12,
                                      ),),
                                    ),
                                    const Icon(Icons.chevron_right,color: Colors.black,)
                                  ],
                                ),


                              ],
                            ).box.white.shadow2xl.margin(const EdgeInsets.symmetric(horizontal: 14)).rounded.clip(Clip.antiAlias).make(),
                          );

                        }));

              }
            },
          ),
        ],
      ),    );
  }
}
