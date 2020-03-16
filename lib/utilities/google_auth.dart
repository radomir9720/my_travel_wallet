import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

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

    return 'OK';
  }
  return 'Юзер отменил авторизацию';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("Юзер вылогинился");
}

void sendDataToFirebase() {
  Map box = currencyPageDataBox.toMap();
  Map<String, dynamic> toAdd = {
    "baseCurrency": box["baseCurrency"],
    "enterSum": box["enterSum"],
    "toConvert": box["toConvert"],
    "travelCard": box["travelCard"],
    "travelCardExpenses": box["travelCardExpenses"],
  };

  _firestore.collection("collection");
  _firestore
      .collection(googleSignIn.currentUser.email)
      .add({"data": toAdd, "addTime": DateTime.now()});
}

void getDataFromFirebase() async {
  final data = await _firestore
      .collection(googleSignIn.currentUser.email)
      .orderBy('addTime', descending: true)
      .getDocuments();
  if (data.documents.length > 0) {
    saveDataToHive(data.documents.first.data["data"]);
  }
}

void saveDataToHive(Map data) {
  currencyPageDataBox.put(kBaseCurrencyKey, data["baseCurrency"]);
  currencyPageDataBox.put(kCurrencyPageToConvertCardKey, data["toConvert"]);
  currencyPageDataBox.put(kCurrencyPageEnterSumFieldKey, data["enterSum"]);

  Map<dynamic, dynamic> tempMap =
      currencyPageDataBox.get(kHomePageTravelCardKey) ?? {};

  // Добавляем карточки путешествий из firebase
  if (data["travelCard"] != null) {
    data["travelCard"].forEach((key, value) {
      tempMap[key] = value;
    });
    currencyPageDataBox.put(kHomePageTravelCardKey, tempMap);
  }

  // Добавляем расходы по каждому путешествию.
  tempMap = currencyPageDataBox.get(kHomePageTravelExpensesKey) ?? {};
  if (data["travelCardExpenses"] != null) {
    Map<dynamic, dynamic> travelDataTempMap;
    data["travelCardExpenses"].forEach((key, value) {
      travelDataTempMap = tempMap[key] ?? {};
      value.forEach((k, v) {
        travelDataTempMap[k] = v;
      });
      tempMap[key] = travelDataTempMap;
    });
    currencyPageDataBox.put(kHomePageTravelExpensesKey, tempMap);
  }
}
