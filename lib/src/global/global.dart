import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
User? currentFirebaseUser;
