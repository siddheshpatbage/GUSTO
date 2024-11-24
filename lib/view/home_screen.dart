import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gusto/model/posts_model.dart';
import 'package:gusto/model/resto_cards.dart';

Widget buildLocationBottomSheet(BuildContext context, RestoCards resto) {
  return Container(
    height: MediaQuery.of(context).size.height / 2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Image.network(
              resto.imgURL,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            resto.restoName,
            style: GoogleFonts.gabarito(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            resto.type,
            style: GoogleFonts.gabarito(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Details about the Place are here.",
            style: GoogleFonts.gabarito(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DocumentSnapshot? response;
  bool isLoading = true; // Track the loading state

  Future<void> fetchData() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      response = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      log("NAME: ${response!['name']}");
      log("URL: ${response!['profileImageUrl']}");
    } catch (e) {
      log("Error fetching data: $e");
    }

    setState(() {
      isLoading = false; // Stop loading
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 4.0,
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  toolbarHeight: 135,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        response != null && response!['name'] != null
                            ? Text(
                                "Hey There ${response!['name']}",
                                style: GoogleFonts.gabarito(
                                  fontSize: 16,
                                ),
                              )
                            : const Text(
                                "Loading...",
                                style: TextStyle(color: Colors.white),
                              ),
                        Container(
                          height: 120,
                          width: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: response != null &&
                                  response!["profileImageUrl"] != null
                              ? Image.network(
                                  "${response!["profileImageUrl"]}",
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                        ),
                        Text(
                          "Ready To Travel",
                          style: GoogleFonts.gabarito(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  expandedHeight: 140,
                  flexibleSpace: CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [0, 1, 2].map(
                      (i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.network(
                                specials[i],
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
                SliverList.builder(
                  itemCount: postsModel.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white10,
                      padding: const EdgeInsets.all(30),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ClayContainer(
                        color: Colors.blueGrey.shade50,
                        spread: 12,
                        depth: 100,
                        borderRadius: 30,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Profile for post
                                  Container(
                                    height: 45,
                                    width: 45,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                        postsModel[index].profileImg),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Post Profile Name
                                      Text(
                                        postsModel[index].name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      //Post Profile Loc
                                      Text(
                                        postsModel[index].location,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      RestoCards resto = RestoCards(
                                        restoName: postsModel[index].location,
                                        imgURL: postsModel[index].postImg,
                                        type: "Type here",
                                        isLike: true,
                                      );
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) =>
                                            buildLocationBottomSheet(
                                                context, resto),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.location_on,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                //Post Image
                                Container(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Image.network(
                                    postsModel[index].postImg,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                //Favourite On post Icon
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "Liked by ${postsModel[index].count}",
                                        style: GoogleFonts.gabarito(
                                            fontSize: 18,
                                            color: Colors.white,
                                            shadows: const [
                                              BoxShadow(offset: Offset(1, 1))
                                            ]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          postsModel[index].isLike =
                                              !postsModel[index].isLike;
                                          if (postsModel[index].isLike ==
                                              true) {
                                            postsModel[index].count++;
                                          }
                                          if (postsModel[index].isLike ==
                                              false) {
                                            postsModel[index].count--;
                                          }
                                          setState(() {});
                                        },
                                        child: postsModel[index].isLike
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
