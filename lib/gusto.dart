import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gusto/view/explore_screen.dart';
import 'package:gusto/view/home_screen.dart';
import 'package:gusto/view/location_screen.dart';
import 'package:gusto/view/profile_screen.dart';
import 'package:gusto/view/reel_screen.dart';
import 'package:image_picker/image_picker.dart';

class Gusto extends StatefulWidget {
  const Gusto({super.key});

  @override
  State<Gusto> createState() => _GustoState();
}

class _GustoState extends State<Gusto> {
  int screenIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const ReelsScreen(),
    const LocationScreen(),
    const ProfileScreen(),
  ];

  File? postImage;

  final ImagePicker picker = ImagePicker();

  // Pick Profile Picture
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        postImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: GNav(
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder:
              Border.all(color: Colors.black, width: 1), // tab button border
          curve: Curves.easeOutExpo, // tab animation curves
          duration: const Duration(milliseconds: 200), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.white, // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 22, // tab button icon size
          tabBackgroundColor: Colors.black, // selected tab background color
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 5), // navigation bar padding
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                screenIndex = 0;
                setState(() {});
              },
            ),
            GButton(
              icon: Icons.explore,
              text: 'Explore',
              onPressed: () {
                screenIndex = 1;
                setState(() {});
              },
            ),
            GButton(
              icon: Icons.slow_motion_video,
              text: 'Reels',
              onPressed: () {
                screenIndex = 2;

                setState(() {});
              },
            ),
            GButton(
              icon: Icons.soup_kitchen,
              text: 'Guide',
              onPressed: () {
                screenIndex = 3;
                setState(() {});
              },
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              onPressed: () {
                screenIndex = 4;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
