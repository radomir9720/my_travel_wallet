import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'dart:convert';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final _firestore = Firestore.instance;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'Юзер залогинен: ${user.email}';
  }
  return 'Юзер отменил авторизацию';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("Юзер вылогинился");
}

void sendDataToFirebase() {
  _firestore.collection(googleSignIn.currentUser.email).add({
    "data":
        jsonDecode(jsonEncode(currencyPageDataBox.toMap().toString())),
    "addTime": DateTime.now(),
  });
}

Future<Map<dynamic, dynamic>> getDataFromFirebase() async {
  final data = await _firestore.collection(googleSignIn.currentUser.email).getDocuments();
  return data.documents.last.data;
}
