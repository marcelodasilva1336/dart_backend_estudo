import '../infra/security/security_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi {
  final SecurityService _securityService;
  LoginApi(this._securityService);
  Handler get handler {
    Router router = Router();

    router.post('/login', (Request req) async {
      // return Response.ok(await _securityService.generateJWT('1'));
      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);

      // return Response.ok((result != null).toString());
      return Response.ok(token);
    });

    return router;
  }
}
