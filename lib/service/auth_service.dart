import 'package:dio/dio.dart';
import 'package:kchat/constants.dart';
import 'package:kchat/model/user.dart';

class AuthService {
  static final _dio =
      Dio(BaseOptions(baseUrl: Constants.apiUrl, validateStatus: (_) => true));

  static Future<String> login(
      {required String username, required String password}) async {
    final response = await _dio.post('/login', data: {
      'username': username,
      'password': password,
    });
    if (response.statusCode != 200) {
      throw Exception(response.data['message'] ?? 'An error occurred');
    }

    return response.data['token'];
  }

  static Future<String> register(
      {required String username,
      required String password,
      required String email,
      required String confirmPassword,
      required String fullName}) async {
    final response = await _dio.post('/register', data: {
      'username': username,
      'password': password,
      'email': email,
      'confirm_password': confirmPassword,
      'full_name': fullName,
    });
    if (response.statusCode != 200) {
      throw Exception(response.data['message'] ?? 'An error occurred');
    }
    return response.data['token'];
  }

  static Future<User> me(String token) async {
    final response = await _dio.get('/me',
        options: Options(headers: {'X-Auth-Token': token}));
    if (response.statusCode != 200) {
      throw Exception(response.data['message'] ?? 'An error occurred');
    }
    return User.fromJson(response.data);
  }
}
