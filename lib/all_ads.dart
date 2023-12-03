



import 'package:birdz_app/category_details.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


class AllAds extends StatefulWidget {
  const AllAds({Key? key}) : super(key: key);

  @override
  State<AllAds> createState() => _AllAdsState();
}

class _AllAdsState extends State<AllAds> {

  var allAds = FirestoreServices.getAllAds();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          StreamBuilder(
            stream: allAds,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child:  loadingIndicator(),
                );
              } else if(snapshot.data!.docs.isEmpty){
                return  const
                Expanded(
                  child: Center(
                    child: Text("No Ads found..",style: TextStyle(color: Vx.gray800),),
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
                          mainAxisExtent: 280,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 8,

                        ),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetails(title: "${data[index]['cp_name']}",data: data[index],)));
                            },
                            child: Column(
                              children: [
                                Image.network(data[index]['cp_imgs'][0],height: 170,width: 160,fit: BoxFit.cover,),
                                const SizedBox(height: 5,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("${data[index]['cp_name']}",style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                ),
                                const SizedBox(height: 8,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Rs ""${data[index]['cp_price']}",style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children:  [
                                      const Icon(Icons.location_on_outlined,size: 18,),
                                      const SizedBox(width: 5,),
                                      Text("${data[index]['cp_location']}"),
                                    ],
                                  ),
                                ),
                              ],
                            ).box.white.shadow2xl.margin(const EdgeInsets.symmetric(horizontal: 14)).rounded.outerShadow2Xl.clip(Clip.antiAlias).make(),
                          );

                        }));

              }
            },
          ),
        ],
      ),
    );
  }
}
