import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/common/values/constants.dart';
import '../../common/widgets/popMessage.dart';
import 'bloc/sign_up_blocs.dart';

class SignUpController{
  final BuildContext context;
  const SignUpController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<SignUpBloc>().state;
    String username = state.username;
    String password = state.password;
    String email = state.email;
    String confirmPassword = state.confirmPassword;

    if(username.isEmpty){
      popMessage(message: "Username cannot be empty!");
      return;
    }
    if(email.isEmpty){
      popMessage(message: "Email cannot be empty!");
      return;
    }
    if(password.isEmpty){
      popMessage(message: "Password cannot be empty!");
      return;
    }
    if(confirmPassword.isEmpty){
      popMessage(message: "Confirm Password cannot be empty!");
      return;
    }

    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password
      );

      if(credential.user!=null){
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(username);
        String photoUrl = "uploads/default.png";
        await credential.user?.updatePhotoURL(photoUrl);

        popMessage(message: "An email has been sent to your email. To activate your account you need to check your email box and click on the link and then you can log in successfully.");
        Navigator.of(context).pop(); // go back to login page

      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        popMessage(message: "Your password is too weak!");
      }else if(e.code == 'email-already-in-use'){
        popMessage(message: "This email is already in use!");
      }else if(e.code == 'invalid-email'){
        popMessage(message: "This email is invalid!");
      }

    }
  }

}
