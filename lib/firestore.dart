import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gusto/model/posts_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch posts from Firestore
  Future<List<PostsModel>> fetchPosts() async {
    try {
      QuerySnapshot snapshot = await _db.collection('posts').get();
      return snapshot.docs.map((doc) {
        return PostsModel(
          profileImg: doc['profileImg'],
          name: doc['name'],
          location: doc['location'],
          postImg: doc['postImg'],
          count: doc['count'],
          isLike: doc['isLike'],
        );
      }).toList();
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  // Update post like status
  Future<void> updatePostLike(String postId, bool isLike, int count) async {
    try {
      await _db.collection('posts').doc(postId).update({
        'isLike': isLike,
        'count': count,
      });
    } catch (e) {
      print("Error updating like status: $e");
    }
  }

  // Add a new post
  Future<void> addPost(PostsModel post) async {
    try {
      await _db.collection('posts').add({
        'profileImg': post.profileImg,
        'name': post.name,
        'location': post.location,
        'postImg': post.postImg,
        'count': post.count,
        'isLike': post.isLike,
      });
    } catch (e) {
      print("Error adding post: $e");
    }
  }
}
