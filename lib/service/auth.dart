import 'package:cafeapp/Models/CafeModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String adminName;
  static List<CafeModel> model;

  //giriş yap fonksiyonu
  Future<User> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    var deneme = await _firestore.collection("admin").doc(user.user.uid).get();
    adminName = deneme['userName'].toString();
    model = await getDocs();

    return user.user;
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  Future<void> click() async {
    model = await getDocs();
  }

//get all cafe
  Future<List<CafeModel>> getDocs() async {
    List<CafeModel> model = new List<CafeModel>();
    var temp = await FirebaseFirestore.instance.collection("cafe").get();
    var data = temp.docs;
    for (var i = 0; i < data.length; i++) {
      CafeModel model1 = new CafeModel();
      model1.adminId = data[i]["adminId"];
      model1.cafeAddress = data[i]["cafeAddress"];
      model1.closeClock = data[i]["closeClock"];
      model1.description = data[i]["description"];
      model1.menu = data[i]["menu"];
      model1.name = data[i]["name"];
      model1.openClock = data[i]["openClock"];
      model1.phoneNumber = data[i]["phoneNumber"];
      model1.picture = data[i]["picture"];
      model1.safeId = data[i]["safeId"];
      String x = await _getDownloadLink(data[i]["picture"]);
      model1.pictureUrl = x;

      model.add(model1);
    }

    return model;
  }

  //dowland picture url
  Future<String> _getDownloadLink(String fileName) async {
    final ref = FirebaseStorage.instance.ref().child('cafeImages/$fileName');
    // no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();
    print(url);
    return url;
  }
  //admin kayıt ol fonksiyonu

  Future<User> createAdmin(
      String name, String email, String password, String PhoneNumber) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    adminName = name;
    await _firestore
        .collection("admin")
        .doc(user.user.uid)
        .set({'userName': name, 'email': email, 'phoneNumber': PhoneNumber});
    await user.user.sendEmailVerification();
    return user.user;
  }

  Future<User> createUser(
      String name, String email, String password, String PhoneNumber) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("user").doc(user.user.uid).set({
      'mailAddress': email,
      'nameSurname': name,
      'phoneNumber': PhoneNumber,
      'userPoint': 100
    });

    return user.user;
  }
}
