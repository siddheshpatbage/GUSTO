import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gusto/model/favorites_model.dart';
import 'package:gusto/view/post_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DocumentSnapshot? response;
  void settingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // Settings Options
                _buildSettingsOption('Account'),
                _buildSettingsOption('Language'),
                _buildSettingsOption('Dark Mode'),
                _buildSettingsOption('Email settings'),
                _buildSettingsOption('Blocked user'),
                _buildSettingsOption('Security'),
                // Logout Button
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.red,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/login",
                        (route) {
                          return false;
                        },
                      );
                    },
                    child: Text(
                      'Logout',
                      style: GoogleFonts.gabarito(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsOption(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: () {
        // Add navigation logic here
      },
    );
  }

  Future<void> fetchData() async {
    response = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    log("NAME: ${response!['name']}");
    log("URL: ${response!['profileImageUrl']}");

    setState(() {});
  }

  bool isFav = true;
  final List<String> highlightImages = [
    'https://plus.unsplash.com/premium_photo-1661771822467-e516ca075314?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHx8MA%3D%3D',
    'https://cdn.pixabay.com/photo/2022/06/07/20/52/curry-7249247_640.jpg',
    'https://images.moneycontrol.com/static-mcnews/2023/10/pexels-zi%E2%80%99s-foodnatureart-9027521.jpg',
    'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=556,505',
    'https://cdn.pixabay.com/photo/2022/06/07/20/52/curry-7249247_640.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () async {
    fetchData();
    //});
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.add), // Leading button icon
          onSelected: (value) {
            if (value == "Post") {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PostScreen();
                  },
                ),
              );
              // Navigate or perform actions for "Post"
            } else if (value == "Hotel") {
              // Navigate or perform actions for "Hotel"
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: "Post",
              child: ListTile(
                leading: Icon(Icons.post_add, color: Colors.black),
                title: Text("Post"),
              ),
            ),
            const PopupMenuItem<String>(
              value: "Hotel",
              child: ListTile(
                leading: Icon(Icons.hotel, color: Colors.black),
                title: Text("Hotel"),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                settingsBottomSheet();
              },
              child: const Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Profile Image
            Container(
              height: 125,
              width: 125,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: response?['profileImageUrl'] != null
                  ? Image.network(
                      response!['profileImageUrl'],
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
            ),

            // Name
            Text(
              response?['name'] ?? "",
              style: GoogleFonts.gabarito(
                fontSize: 20,
              ),
            ),

            // Username
            Text(
              response?['username'] != null ? "@${response!['username']}" : "",
              style: GoogleFonts.gabarito(
                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "3054",
                      style: GoogleFonts.gabarito(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "Follower",
                      style: GoogleFonts.gabarito(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "6",
                      style: GoogleFonts.gabarito(
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "Following",
                      style: GoogleFonts.gabarito(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),

            // "My Highlights" Section
            Text(
              "My Highlights",
              style: GoogleFonts.gabarito(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 100, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: highlightImages.length, // Number of highlight images
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(4, 4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(-4, -4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(highlightImages[
                              index]), // Use each image from the list
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Favorites",
                    style: GoogleFonts.gabarito(
                      fontSize: 23,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 200,
                          width: 300,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 0.8,
                                spreadRadius: 1,
                                color: Colors.grey,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Image.network(
                            favoriteList[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                favoriteList.removeAt(index);
                              });
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //       content: Text("Removed from Favourites")),
                              // );
                            },
                            child: isFav
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    shadows: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    size: 30,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
