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


  void login(email,password,context)async{
    try{
      final Session user=await account.createEmailPasswordSession(email: email, password: password);
      if(user!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }

    }catch(e){
        print(e);
    }

  }
}