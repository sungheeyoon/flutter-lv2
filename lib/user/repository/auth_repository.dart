import 'package:dio/dio.dart';
import 'package:flutter_lv2/common/const/data.dart';
import 'package:flutter_lv2/common/dio/dio.dart';
import 'package:flutter_lv2/common/model/login_response.dart';
import 'package:flutter_lv2/common/model/token_response.dart';
import 'package:flutter_lv2/common/utils/data_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(dio: dio, baseUrl: 'http://$ip/auth');
});

class AuthRepository {
  // http://$ip/auth
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized ',
        },
      ),
    );

    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(
        headers: {
          'refreshToken': 'true',
        },
      ),
    );
    return TokenResponse.fromJson(
      resp.data,
    );
  }
}
