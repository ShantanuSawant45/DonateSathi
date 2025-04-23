import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '../screens/home_page.dart';

class Appwrite_Auth{
  
  late Client client;
  late Account account;

  void Intialize(){
     client=Client()
         .setEndpoint("https://cloud.appwrite.io/v1")
         .setProject("67deb3f600293c6eb665");
     account=Account(client);
  }
  
  void signup(email,password,context)async{
    try {
      final User user =await account.create(userId: ID.unique(), email: email, password: password);
      // this are  the lines so that user gets logged in automatically after registration
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      if (user!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
    }catch(e){
      print(e);
    }
  }


  void login(String email, String password, BuildContext context) async {
    try {
      // Attempt to create a session
      final Session session = await account.createEmailPasswordSession(
          email: email,
          password: password
      );

      // If session is successfully created, navigate to HomePage
      if (session != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage())
        );
      }
    } on AppwriteException catch (e) {
      // Handle specific Appwrite authentication errors
      String errorMessage = 'Login failed';

      switch (e.code) {
        case 401:
          errorMessage = 'Invalid email or password';
          break;
        case 429:
          errorMessage = 'Too many login attempts. Please try again later.';
          break;
        case 400:
          errorMessage = 'Invalid login credentials';
          break;
        default:
          errorMessage = e.message ?? 'An unexpected error occurred';
      }

      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          )
      );
    } catch (e) {
      // Catch any other unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred'),
            backgroundColor: Colors.red,
          )
      );
      print('Unexpected login error: $e');
    }
  }
}
