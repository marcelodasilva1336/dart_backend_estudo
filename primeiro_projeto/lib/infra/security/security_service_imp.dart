import 'package:primeiro_projeto/utils/custon_env.dart';
import 'security_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT(
      {
        'iat': DateTime.now().microsecondsSinceEpoch,
        'userId': userID,
        'roles': ['admin', 'user']
      },
    );

    String key = await CustomEnv.get(key: 'jwt_key');
    String token = jwt.sign(SecretKey(key));

    return token;
  }

  @override
  JWT? validateJWT(String token) {
    // TODO: implement validateJWT
    throw UnimplementedError();
  }
}