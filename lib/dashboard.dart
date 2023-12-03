import 'package:birdz_app/chats/messages_list_screen.dart';
import 'package:birdz_app/controller/home_controller.dart';
import 'package:birdz_app/home_screen.dart';
import 'package:birdz_app/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_ads.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBarItems = const [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
          ),
          label: 'Messages'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.sell,
          ),
          label: 'My Ads'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'Profile'),
    ];
    var navBody = [
      const Home(),
      const MessagesListScreen(),
      const MyAds(),
      const Profile(),
    ];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green.shade700,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800),
            selectedItemColor: Colors.grey.shade900,
            unselectedItemColor: Colors.white,
            items: navBarItems,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),

        ),
      ),
    );
  }
}



