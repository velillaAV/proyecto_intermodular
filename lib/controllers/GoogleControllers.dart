import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleControllers {

  static String? nombre = "";
  static String? email = "";
  static String? fotoRuta = "";

  static Future<User?> loginGoogle() async {

    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.addScope('email');
        provider.addScope('profile');

        final UserCredential = await FirebaseAuth.instance.signInWithPopup(provider);
        final user = UserCredential.user;

        nombre = user?.displayName;
        email = user?.email;
        fotoRuta = user?.photoURL;
        return user;
      }else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if(googleUser == null )  {
          return null;
        }
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        final UserCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final user = UserCredential.user;

        nombre = user?.displayName;
        email = user?.email;
        fotoRuta = user?.photoURL;
        return user;
      }

      
      

      
    } catch (e) {
      return null;
    }



  }







}