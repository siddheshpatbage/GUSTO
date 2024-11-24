import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gusto/model/favorites_model.dart';
import 'package:gusto/model/resto_cards.dart'; // Replace with your model

class DetailScreen extends StatelessWidget {
  final RestoCards resto;

  const DetailScreen({super.key, required this.resto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            floating: false,
            pinned: true,
            flexibleSpace: Hero(
              tag: resto
                  .imgURL, // The same tag used in the LocationScreen for the Hero widget
              child: Image.network(
                resto.imgURL,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    resto.restoName,
                    style: GoogleFonts.gabarito(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    resto.type,
                    style: GoogleFonts.gabarito(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Details about the restaurant will be displayed here. This can include information like the menu, reviews, opening hours, and much more.",
                    style: GoogleFonts.gabarito(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      favoriteList.add(FavoritesModel(
                          imageUrl: resto.imgURL, isLiked: true));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Add to Favorites",
                      style: GoogleFonts.gabarito(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
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
