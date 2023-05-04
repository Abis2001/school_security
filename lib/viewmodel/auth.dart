import 'package:flutter/widgets.dart';
import 'package:school_security/model/auth/login_model.dart';
import 'package:school_security/services/auth/login_api.dart';

class Auth extends ChangeNotifier{
  LoginModel loginData=LoginModel();
  bool isLoading=false;
  Future<LoginModel> login({required String phoneNumber,required String password,required BuildContext context})async{
    isLoading=true;
    loginData=await AuthApi().login(phoneNumber: phoneNumber, password: password, context: context);
    isLoading=false;
    return loginData;
  }
}