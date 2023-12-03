



import 'package:birdz_app/controller/catergory_controller.dart';
import 'package:birdz_app/category_details.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryMain extends StatefulWidget {
  final String? title;
  const CategoryMain({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryMain> createState() => _CategoryMainState();
}

class _CategoryMainState extends State<CategoryMain> {

  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    }
    else{
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<CategoryController>();

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.greenAccent.shade400,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // uncomment this code to ad a subcategories on the top, but this code is having problem

          // SingleChildScrollView(
          //   physics: const BouncingScrollPhysics(),
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: List.generate(controller.subcat.length, (index) => "${controller.subcat[index]}".text
          //         .fontWeight(FontWeight.bold).size(15)
          //         .color(Colors.black)
          //         .makeCentered()
          //         .box.green200.rounded
          //         .size(130, 50)
          //         .margin(const EdgeInsets.all(10)).shadow
          //         .make().onTap(() {
          //           switchCategory("${controller.subcat[index]}");
          //           setState(() {});
          //     })),
          //
          //   ),
          // ),
          const SizedBox(height: 20,),
          StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                 return Center(
                   child:  loadingIndicator(),
                 );
                } else if(snapshot.data!.docs.isEmpty){
                  return  const
                   Expanded(
                    child: Center(
                      child: Text("No Products found..",style: TextStyle(color: Vx.gray800),),
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
