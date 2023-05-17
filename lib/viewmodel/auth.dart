import 'package:flutter/widgets.dart';
import 'package:school_security/model/auth/login_model.dart';
import 'package:school_security/model/auth/register_model.dart';
import 'package:school_security/services/auth/auth.dart';

class Auth extends ChangeNotifier{
  LoginModel loginData=LoginModel();
  RegisterModel registerData=RegisterModel();
  bool isLoading=false;
  Future<LoginModel> login({required String phoneNumber,required String password,required BuildContext context})async{
    isLoading=true;
    loginData=await AuthApi().login(phoneNumber: phoneNumber, password: password, context: context);
    isLoading=false;
    return loginData;
  }

   Future<RegisterModel> register({required String userName,required String phoneNumber,required String password,required String email,required int role,required BuildContext context})async{
    isLoading=true;
    registerData=await AuthApi().register(phoneNumber: phoneNumber, password: password, context: context,email: email,role: role,userName: userName);
    isLoading=false;
    return registerData;
  }
}