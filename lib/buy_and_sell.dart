import 'package:birdz_app/all_ads.dart';
import 'package:birdz_app/category_details.dart';
import 'package:birdz_app/category_screen.dart';
import 'package:birdz_app/controller/catergory_controller.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:birdz_app/featured_ads_main.dart';
import 'package:birdz_app/widgets/buysell_two_widget.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'category_main.dart';
import 'consts/lists.dart';

class BuySell extends StatefulWidget {
  const BuySell({Key? key}) : super(key: key);

  @override
  State<BuySell> createState() => _BuySellState();
}

class _BuySellState extends State<BuySell> {
  var controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.width / 0.25,
        color: Colors.green.shade100,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AllAds() ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/marketIcon.webp",width: 50,height: 40,),
                      const SizedBox(height: 5,),
                      const Text("All Ads",style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ).box.shadow.width(double.infinity).height(85).margin(const EdgeInsets.symmetric(horizontal: 4)).color(Colors.white).padding(const EdgeInsets.all(10)).roundedSM.outerShadowSm.make(),
                ),
              ),
              const SizedBox(height: 20,),
              VxSwiper.builder(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  itemCount: homesliderList.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        homesliderList[index],
                        fit: BoxFit.cover,
                      ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 4)).make(),
                    );
                  }),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children:  [
                        const Text("Featured Categories", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          fontSize: 20,
                        ),),
                       InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context) => const CategoryScreen() ));
                         },
                         child: const Text("See All",style: TextStyle(
                             decoration: TextDecoration.underline,fontWeight: FontWeight.bold,fontSize: 13),),
                       )
                     ],
                   ),
                ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(4, (index) {
                      return InkWell(
                      onTap: () {
                        controller.getSubCategories(catergoryListTxt[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryMain(
                                    title: catergoryListTxt[index])));
                      },
                      child: Column(
                        children: [
                          featuredAds(
                              img: categoryListImg[index],
                              title: catergoryListTxt[index]),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ));
                })),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Featured Ads",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => const FeaturedAdsMain() ));
                              },
                              child: const Text("See All",style: TextStyle(
                                  decoration: TextDecoration.underline,fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FutureBuilder(
                          future: FirestoreServices.getFeaturedProducts(),
                          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                            if(!snapshot.hasData){
                              return Center(
                                child: loadingIndicator(),
                              );
                            } else if(snapshot.data!.docs.isEmpty){
                              return const Text("No featured products found");
                            } else{
                              var featuredAds = snapshot.data!.docs;

                              return Row(
                                children: List.generate(
                                    featuredAds.length,
                                        (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5,),
                                    Image.network(featuredAds[index]['cp_imgs'][0],width: 150,height: 150,fit: BoxFit.cover,),
                                    const SizedBox(height: 10,),
                                    Text("${featuredAds[index]['cp_name']}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                                    const SizedBox(height: 5,),
                                    Text("Rs ""${featuredAds[index]['cp_price']}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                                    const SizedBox(height: 20,),
                                    Row(
                                      children:  [
                                        const Icon(Icons.location_on_outlined,size: 18,),
                                        const SizedBox(width: 5,),
                                        Text("${featuredAds[index]['cp_location']}"),
                                      ],
                                    ),
                                  ],
                                ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make()
                                .onTap(() {
                                  Get.to(() => CategoryDetails(
                                          title: "${featuredAds[index]['cp_name']}",
                                        data: featuredAds[index],
                                      ));
                                        })),
                              );
                            }

                          },

                        ),
                      )
                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
