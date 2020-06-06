import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

final FirebaseAuth _auth = FirebaseAuth.instance;
 String email;
 String password;



//sign in anonymously

Future signInAnon() async {

  try{
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return user;
  }catch(e){
    print(e.toString());
    return null;
  }
  }
// stream onAuthChange
  Stream<FirebaseUser> get user {
  return _auth.onAuthStateChanged;
  }

//register with email and password

Future registerWithEmailAndPassword(String email, String password) async{
  try{
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user;
  }catch(e){
    print(e.toString());
    return null;
  }


}

//sign in with email and password
Future signInWithEmailAndPassword(String email, String password) async {

  try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user;
  }catch(e){
    print(e.toString());
    return null;
  }

}

// logout

Future logOut() async{
try{
  return await _auth.signOut();

}
 catch(e){
  print(e.toString());
  return e.toString();

 }
  }
}
