import 'package:birdz_app/category_details.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';



// PROBLEM:  comment var filtered and then replace all 'filtered' with data , after reloading the pixel rendor problem from bottom will be shown.....


class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("$title",style: TextStyle(color: Colors.grey.shade700),),
        backgroundColor: Colors.green.shade200,
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          } else if(snapshot.data!.docs.isEmpty){
            return const Center(
              child: Text("No products found"),
            );
          }
          else{
            var data = snapshot.data!.docs;
            var filtered = data.where((element) => element['cp_name'].toString().toLowerCase().contains(title!.toLowerCase()),).toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 6,mainAxisExtent: 260,),
                  children: filtered.mapIndexed((currentValue, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          filtered[index]['cp_imgs'][0],
                          width: 140,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 5,),
                        Text("${filtered[index]['cp_name']}", style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16,),),
                        const SizedBox(height: 5,),
                        Text("Rs ""${filtered[index]['cp_price']}",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on,size: 17,),
                            Text("${filtered[index]['cp_location']}"),
                          ],
                        )
                      ],
                    ).box.white.shadow3xl.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
                      Get.to(() =>
                      CategoryDetails(title: "${filtered[index]['cp_name']}",
                      data: filtered[index],
                      ));
                  })
                  ).toList(),
                  ),
                ),
              ],
            );
            
          }

        },
      )
    );
  }
}
