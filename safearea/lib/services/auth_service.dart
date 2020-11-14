import 'dart:convert';
import 'dart:io';

import 'package:safearea/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService{
  static final AuthService authService = AuthService._();
  AuthService._();

  static final _uriAuth = "https://tsc-safe-areas.herokuapp.com/login";
  static final _uriTokenNotify = "https://tsc-safe-areas.herokuapp.com/updateToken";

  Future<UserModel> auth(String usuario, String contrasena) async{
    final response   = await http.post(_uriAuth,
                              headers: { HttpHeaders.contentTypeHeader: 'application/json'},
                              body: jsonEncode(<String, String>{
                              'correo': usuario,
                              'contrasena': contrasena
                            }));
    
    final decodeData = json.decode(response.body);
    final userData = decodeData['status'] == 200 ? new UserModel.fromJsonData(decodeData['response']) : null;
    return userData;
  }

  Future<int> postToken(int idUser, String token) async{
    final response   = await http.post(_uriTokenNotify,
                             headers: { HttpHeaders.contentTypeHeader: 'application/json'},
                              body: jsonEncode(<String, String>{
                              'idUser': idUser.toString(),
                              'token': token
                            }));
                            print("========== SERVICE ==========");
    print(token);
    final decodeData = json.decode(response.body);
    return decodeData['status'];
  }
}