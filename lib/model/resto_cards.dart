class RestoCards {
  final String restoName;
  final String type;
  bool isLike = false;
  final String imgURL;

  RestoCards({
    required this.restoName,
    required this.type,
    required this.imgURL,
    required this.isLike,
  });
}

Map<String, List<RestoCards>> restaurantsByLocation = {
  "Italy": [
    RestoCards(
      restoName: "Casa Perbellini",
      type: "Fine Dining",
      imgURL:
          "https://picsum.photos/200/300?random=1", // Example for Fine Dining
      isLike: false,
    ),
    RestoCards(
      restoName: "Campo del Drago",
      type: "Italian",
      imgURL:
          "https://picsum.photos/200/300?random=2", // Example for Italian cuisine
      isLike: false,
    ),
    RestoCards(
      restoName: "Villa Elena",
      type: "Traditional",
      imgURL:
          "https://picsum.photos/200/300?random=3", // Example for Traditional cuisine
      isLike: false,
    ),
  ],
  "Tokyo": [
    RestoCards(
      restoName: "Sukiyabashi Jiro",
      type: "Sushi",
      imgURL: "https://picsum.photos/200/300?random=4", // Sushi restaurant
      isLike: false,
    ),
    RestoCards(
      restoName: "Narisawa",
      type: "Japanese Fine Dining",
      imgURL: "https://picsum.photos/200/300?random=5", // Japanese fine dining
      isLike: false,
    ),
    RestoCards(
      restoName: "Den",
      type: "Modern Japanese",
      imgURL: "https://picsum.photos/200/300?random=6", // Modern Japanese
      isLike: false,
    ),
  ],
  "New York": [
    RestoCards(
      restoName: "Eleven Madison Park",
      type: "Fine Dining",
      imgURL: "https://picsum.photos/200/300?random=7", // Fine Dining
      isLike: false,
    ),
    RestoCards(
      restoName: "Per Se",
      type: "Contemporary American",
      imgURL: "https://picsum.photos/200/300?random=8", // Contemporary American
      isLike: false,
    ),
    RestoCards(
      restoName: "Le Bernardin",
      type: "French Seafood",
      imgURL: "https://picsum.photos/200/300?random=9", // French Seafood
      isLike: false,
    ),
  ],
  "Paris": [
    RestoCards(
      restoName: "Le Meurice",
      type: "Luxury French",
      imgURL: "https://picsum.photos/200/300?random=10", // Luxury French
      isLike: false,
    ),
    RestoCards(
      restoName: "L'Arpège",
      type: "Vegetarian Fine Dining",
      imgURL:
          "https://picsum.photos/200/300?random=11", // Vegetarian Fine Dining
      isLike: false,
    ),
    RestoCards(
      restoName: "Pierre Gagnaire",
      type: "Modern French",
      imgURL: "https://picsum.photos/200/300?random=12", // Modern French
      isLike: false,
    ),
  ],
  "London": [
    RestoCards(
      restoName: "The Ledbury",
      type: "Modern European",
      imgURL: "https://picsum.photos/200/300?random=13", // Modern European
      isLike: false,
    ),
    RestoCards(
      restoName: "Dinner by Heston Blumenthal",
      type: "Experimental",
      imgURL: "https://picsum.photos/200/300?random=14", // Experimental cuisine
      isLike: false,
    ),
    RestoCards(
      restoName: "Core by Clare Smyth",
      type: "Contemporary British",
      imgURL: "https://picsum.photos/200/300?random=15", // Contemporary British
      isLike: false,
    ),
  ],
};
