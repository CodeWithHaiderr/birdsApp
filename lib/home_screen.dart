import 'package:birdz_app/components/search_screen.dart';
import 'package:birdz_app/consts/lists.dart';
import 'package:birdz_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'birds_info.dart';
import 'breeding_guide.dart';
import 'buy_and_sell.dart';
import 'medication.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.find<HomeController>();
  Icon searchIcon = const Icon(Icons.search);

  Widget customSearchBarTxt = const Text(
    'Search',
    style: TextStyle(fontWeight: FontWeight.bold),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 80),
            height: 150,
            color: Colors.white,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.green,
                ).onTap(() {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen(
                                  title: controller.searchController.text,
                                )));
                  }
                }),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Ads..",
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
            ).box.outerShadowSm.padding(const EdgeInsets.all(10)).make(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: VxSwiper.builder(
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                autoPlay: true,
                itemCount: homesliderList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      homesliderList[index],
                      fit: BoxFit.fitWidth,
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300, left: 20, right: 20),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BirdsInfo()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.green.shade500,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_sharp,
                          size: 45,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Birds Info',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BreedingGuide()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.green.shade500,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.tips_and_updates,
                          size: 45,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Breeding Guide',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BuySell()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.green.shade500,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store,
                          size: 45,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Buy and Sell',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Medication()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.green.shade500,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_information,
                          size: 45,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Medication',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
