import 'package:birdz_app/consts/firebase_consts.dart';
import 'package:birdz_app/consts/lists.dart';
import 'package:birdz_app/controller/post_product_controller.dart';
import 'package:birdz_app/my_ad_details.dart';
import 'package:birdz_app/post_new_ad.dart';
import 'package:birdz_app/services/firestore_services.dart';
import 'package:birdz_app/widgets/ads_button.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:velocity_x/velocity_x.dart';

class MyAds extends StatelessWidget {
  const MyAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PostProductController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const PostNewAd()));
          },
          backgroundColor: Colors.purple,
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            "My Ads ",
            style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          actions: [
            Center(
                child: Text(
              intl.DateFormat.yMd().add_jm().format(DateTime.now()),
              style: TextStyle(
                  color: Colors.purple.shade800, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getMyAds(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        myAdsButton(context,
                                title: "Total Ads",
                                count: "${data.length}",
                                icon: Icons.store),
                        //     .onTap(() {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const MyAllAds()));
                        // }),
                    //     myAdsButton(context,
                    //         title: "Active Ads",
                    //         count: "5",
                    //         icon: CupertinoIcons.cube_box_fill),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     myAdsButton(context,
                    //         title: "Removed Ads",
                    //         count: "10",
                    //         icon: Icons.delete),
                    //     myAdsButton(context,
                    //         title: "Inactive Ads",
                    //         count: "5",
                    //         icon: Icons.cancel),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Divider(),
                    Text(
                      "My Ads",
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            data.length,
                            (index) => Card(
                                  child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyAdDetails(
                                                      title:
                                                          "${data[index]['cp_name']}",
                                                      data: data[index],
                                                    )));
                                      },
                                      leading: Image.network(
                                        "${data[index]['cp_imgs'][0]}",

                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(
                                        "${data[index]['cp_name']}",
                                        style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            "${data[index]['cp_price']}",
                                            style: TextStyle(
                                                color: Colors.grey.shade900),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data[index]['is_featured'] == true
                                                ? "Featured"
                                                : '',
                                            style:
                                                const TextStyle(color: Colors.green),
                                          ),
                                        ],
                                      ),
                                      trailing: VxPopupMenu(
                                        menuBuilder: () => Column(
                                          children: List.generate(
                                            adPopupMenuTxt.length,
                                            (i) => Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Row(
                                                children: [
                                                  Icon(adPopupMenuIcons[i],
                                                    color: data[index]['featured_id'] == currentUser!.uid && i == 0 ? Colors.green : Colors.grey.shade800,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    data[index]['featured_id'] == currentUser!.uid && i == 0 ? "Remove featured"
                                                    : adPopupMenuTxt[i],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade900,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ).onTap(() {
                                                switch(i){
                                                  case 0:
                                                    if(data[index]['is_featured'] == true){
                                                      controller.removeFeatured(data[index].id);
                                                      VxToast.show(context, msg: "Removed ");
                                                    }
                                                    else{
                                                      controller.adFeatured(data[index].id);
                                                      VxToast.show(context, msg: "Added");
                                                    }
                                                    break;
                                                  case 1:
                                                    break;
                                                  case 2:
                                                    controller.deleteProduct(data[index].id);
                                                    loadingIndicator();
                                                    VxToast.show(context, msg: "Ad deleted");
                                                    break;
                                                  default:
                                                }
                                              }),
                                            ),
                                          ),
                                        )
                                            .box
                                            .white
                                            .roundedSM
                                            .shadow2xl
                                            .width(200)
                                            .make(),
                                        clickType: VxClickType.singleClick,
                                        child: const Icon(Icons.more_vert),
                                      )),
                                )),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
