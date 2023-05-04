import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_security/model/auth/login_model.dart';
import 'package:school_security/services/dio/dio.dart';

import '../../constants/endpoints.dart';
import '../dio/logger/logger_interceptor.dart';
class AuthApi{
DioClient dio=DioClient();
LoginModel loginData=LoginModel();
Future<LoginModel> login({required String phoneNumber,required String password,required BuildContext context}) async {
    Map loginBody = {
      "password": password.toString(),
      "phoneNumber": phoneNumber.toString()
    };
    try {
      final response = await dio.dio.post(
        Endpoints.loginUrl,
        data: loginBody,
      );
      loginData = LoginModel.fromMap(response.data);
      return loginData;
    } on DioError catch (e) {
      if (kDebugMode) {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return apiFailure(context: context, error: e.toString());
        //   },
        // );
      } else {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return technicalFailure(context);
        //   },
        // );
      }

      throw Exception(e);
    } catch (e) {
      logDebug(e.toString(), level: Level.error);
      throw e.toString();
    }
  }}