class FavoritesModel {
  String imageUrl;
  bool isLiked;

  FavoritesModel({
    required this.imageUrl,
    required this.isLiked,
  });
}

List<FavoritesModel> favoriteList = [];
