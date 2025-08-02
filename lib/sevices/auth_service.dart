import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      // Begin interaction with the Google Sign-In
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // Check if the user is null (canceled sign-in)
      if (gUser == null) {
        // Return null if the user cancels the sign-in process
        return null;
      }

      // Obtain authentication details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Finally, sign in with the credentials
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      // Handle errors if any occur during the sign-in process
      //print("Google sign-in error: $e");
      return null;
    }
  }
}
