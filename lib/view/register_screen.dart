import 'dart:io'; // For File
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For Storage
import 'package:image_picker/image_picker.dart'; // For Image Picker

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? _profileImage; // For selected image
  bool _isLoading = false;

  // Function to pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to upload image to Firebase Storage
  Future<String> _uploadProfileImage(String userId) async {
    final storageRef = _storage.ref().child('profile_images/$userId.jpg');
    await storageRef.putFile(_profileImage!);
    return await storageRef.getDownloadURL();
  }

  // Register User Function
  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (_profileImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select a profile image."),
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        // Create user with email and password
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get the current user
        final user = userCredential.user;

        if (user != null) {
          // Upload profile image and get URL
          final profileImageUrl = await _uploadProfileImage(user.uid);

          // Save user details to Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'name': _nameController.text.trim(),
            'username': _usernameController.text.trim(),
            'email': user.email,
            'profileImageUrl': profileImageUrl, // Save profile image URL
            'createdAt': FieldValue.serverTimestamp(),
            'uid': user.uid,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registration Successful!"),
            ),
          );

          // Navigate to login screen
          Navigator.of(context).pushReplacementNamed('/login');
        }
      } on FirebaseAuthException catch (e) {
        String message = "An error occurred. Please try again.";
        if (e.code == 'email-already-in-use') {
          message = "The email is already in use.";
        } else if (e.code == 'weak-password') {
          message = "The password is too weak.";
        } else if (e.code == 'invalid-email') {
          message = "Invalid email address.";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),

                  // Profile Image Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[500],
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.camera_alt,
                              size: 70, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Name Field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your full name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Username Field
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email.";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value)) {
                        return "Please enter a valid email.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password.";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Confirm Password Field
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password.";
                      } else if (value != _passwordController.text) {
                        return "Passwords do not match.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : ElevatedButton(
                          onPressed: _registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size(400, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Register",
                            style: GoogleFonts.gabarito(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.gabarito(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text(
                          "Login here!",
                          style: GoogleFonts.gabarito(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
