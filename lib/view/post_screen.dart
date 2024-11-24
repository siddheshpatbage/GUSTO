import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  File? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  // Function to fetch current user's name from Firestore
  Future<void> fetchUserName() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userDoc.exists && userDoc.data() != null) {
        final userName = userDoc.data()!['name'] ?? 'Anonymous';
        setState(() {
          nameController.text = userName;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user name: $e')),
      );
    }
  }

  // Function to pick an image from the gallery
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  // Function to upload image to Firebase Storage and return the URL
  Future<String> uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('posts/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(image);

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // Function to save the post data to Firestore
  Future<void> savePost() async {
    if (nameController.text.isEmpty ||
        locationController.text.isEmpty ||
        selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and select an image')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Upload image to Firebase Storage
      final postImageUrl = await uploadImage(selectedImage!);

      // Get the current user's profile image URL
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final profileImageUrl = userDoc['profileImageUrl'];

      // Save post details to Firestore
      await FirebaseFirestore.instance.collection('posts').add({
        'profileImg': profileImageUrl,
        'name': nameController.text,
        'location': locationController.text,
        'postImg': postImageUrl,
        'count': 0,
        'isLike': false,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post added successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Input
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 16),

                  // Image Picker
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: selectedImage == null
                          ? const Center(child: Text('Tap to select an image'))
                          : Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Location Input
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                  ),
                  const SizedBox(height: 16),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: savePost,
                      child: const Text('Post'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
