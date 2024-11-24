import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gusto/model/resto_cards.dart';
import 'package:gusto/view/details_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            toolbarHeight: 70,
            title: ClayContainer(
              spread: 8,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                String location = restaurantsByLocation.keys.elementAt(index);
                List<RestoCards> restaurants =
                    restaurantsByLocation[location] ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 16),
                      child: Text(
                        location,
                        style: GoogleFonts.gabarito(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 270,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          RestoCards resto = restaurants[index];
                          return Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: // Wrap the restaurant card in Hero widget
                                    GestureDetector(
                                  onTap: () {
                                    // Navigate to a detail page with Hero transition
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            resto:
                                                resto), // Replace with your detail screen
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: resto
                                        .imgURL, // Use a unique tag (e.g., resto's image URL)
                                    child: ClayContainer(
                                      spread: 4,
                                      borderRadius: 20,
                                      width: 170,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            height: 170,
                                            width: 170,
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
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                              resto.restoName,
                                              style: GoogleFonts.gabarito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                              resto.type,
                                              style: GoogleFonts.gabarito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //Favourite On post Icon
                              // Padding(
                              //   padding: const EdgeInsets.all(15),
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       setState(() {
                              //         // Toggle the like status
                              //         restaurants[index].isLike =
                              //             !restaurants[index].isLike;

                              //         // If the card is liked, add it to the favoriteList
                              //         if (restaurants[index].isLike) {
                              //
                              //         } else {
                              //           // If it's unliked, remove it from the favoriteList
                              //           favoriteList.removeWhere((favorite) =>
                              //               favorite.imageUrl ==
                              //               restaurants[index].imgURL);
                              //         }
                              //       });
                              //     },
                              //     child: resto.isLike
                              //         ? const Icon(
                              //             Icons.favorite,
                              //             color: Colors.red,
                              //             shadows: [
                              //               BoxShadow(
                              //                 blurRadius: 4,
                              //                 offset: Offset(0, 2),
                              //               ),
                              //             ],
                              //             size: 30,
                              //           )
                              //         : const Icon(
                              //             Icons.favorite_border_outlined,
                              //             color: Colors.white,
                              //             shadows: [
                              //               BoxShadow(
                              //                 blurRadius: 4,
                              //                 offset: Offset(0, 2),
                              //               ),
                              //             ],
                              //             size: 30,
                              //           ),
                              //   ),
                              // ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              childCount: restaurantsByLocation.keys.length,
            ),
          ),
        ],
      ),
    );
  }
}
