import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:gusto/model/favorites_model.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  final List<String> images = [
    'https://static.independent.co.uk/s3fs-public/thumbnails/image/2014/03/25/12/eiffel.jpg',
    'https://cms.musafir.com/uploads/1920x1080_Beauty_of_Taj_Mahal_1_6ca4fe9fe7.jpg',
    'https://cdn.mos.cms.futurecdn.net/5pCA2Sgpfj9Vu8XcALuMtb-1200-80.jpg',
    'https://www.worldatlas.com/upload/f4/d8/7b/shutterstock-1397031029.jpg',
    'https://www.ft.com/__origami/service/image/v2/images/raw/https://s3-eu-west-1.amazonaws.com/htsi-ez-prod/ez/images/8/9/6/4/974698-1-eng-GB/main_92676b45-5b17-406d-8e56-c268437e8dac.jpg?height=930&dpr=1&format=jpg&source=htsi',
    'https://i0.wp.com/www.touristegypt.com/wp-content/uploads/2023/01/Cairo-Luxor-and-Highlights-of-Egypt-tour-from-Eilat-or-Tel-Aviv-4-days-1-e1678279893887.jpg?fit=1200%2C558&ssl=1',
    'https://cdn.britannica.com/36/162636-050-932C5D49/Colosseum-Rome-Italy.jpg',
    'https://smilingway.cz/wp-content/uploads/2023/10/Amsterdam-za-1-den-1500x844.jpeg',
  ];

  String? selectedImage;
  Offset? longPressPosition;
  String? actionMessage; // Variable to hold the action message
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showCircularMenu(String image, Offset position) {
    setState(() {
      selectedImage = image;
      longPressPosition = position;
    });
    _controller.forward(from: 0);
  }

  void closeCircularMenu() {
    _controller.reverse();
    setState(() {
      selectedImage = null;
      actionMessage = null; // Clear message when menu is closed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: [
          // Grid of Images
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPressStart: (details) {
                    showCircularMenu(images[index], details.globalPosition);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Dark Overlay when menu is active
          if (selectedImage != null)
            GestureDetector(
              onTap: closeCircularMenu,
              child: AnimatedOpacity(
                opacity: selectedImage != null ? 0.8 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),

          // Circular Utilities Menu
          if (selectedImage != null && longPressPosition != null)
            Positioned(
              top: longPressPosition!.dy - 100,
              left: longPressPosition!.dx - 100,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOutBack,
                ),
                child: CircularMenu(
                  onClose: closeCircularMenu,
                  onFavorite: () {
                    favoriteList.add(
                      FavoritesModel(
                        imageUrl: selectedImage.toString(),
                        isLiked: true,
                      ),
                    );
                    setState(() {
                      actionMessage = "Added to Favorites!"; // Display message
                    });
                  },
                  onSave: () {
                    setState(() {
                      actionMessage = "Saved!"; // Display message
                    });
                  },
                  onShare: () {
                    setState(() {
                      actionMessage = "Shared!"; // Display message
                    });
                  },
                ),
              ),
            ),

          // Display action message in the center of the screen
          if (actionMessage != null)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 -
                  30, // Center vertically
              left: MediaQuery.of(context).size.width / 2 -
                  100, // Center horizontally
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    actionMessage!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CircularMenu extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onFavorite;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const CircularMenu({
    super.key,
    required this.onClose,
    required this.onFavorite,
    required this.onSave,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Circle
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
        // Favorite Button
        Positioned(
          top: 20,
          child: CircularMenuButton(
            icon: Icons.favorite,
            color: Colors.red,
            onPressed: onFavorite,
          ),
        ),
        // Save Button
        Positioned(
          right: 20,
          child: CircularMenuButton(
            icon: Icons.save_alt,
            color: Colors.blue,
            onPressed: onSave,
          ),
        ),
        // Share Button
        Positioned(
          bottom: 20,
          child: CircularMenuButton(
            icon: Icons.share,
            color: Colors.green,
            onPressed: onShare,
          ),
        ),
        // Close Button
        Positioned(
          left: 20,
          child: CircularMenuButton(
            icon: Icons.close,
            color: Colors.grey,
            onPressed: onClose,
          ),
        ),
      ],
    );
  }
}

class CircularMenuButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const CircularMenuButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: color.withOpacity(0.15),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
