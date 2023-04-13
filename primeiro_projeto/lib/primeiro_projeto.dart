import 'package:primeiro_projeto/apis/blog_api.dart';
import 'package:primeiro_projeto/apis/login_api.dart';
import 'package:primeiro_projeto/infra/custon_server.dart';
import 'package:primeiro_projeto/infra/middleware_interception.dart';
import 'package:primeiro_projeto/infra/security/security_service_imp.dart';
import 'package:primeiro_projeto/services/noticia_service.dart';
import 'package:primeiro_projeto/utils/custon_env.dart';
import 'package:shelf/shelf.dart';

void main() async {
  // CustomEnv.fromFil  e('.env-dev');

  var cascadeHandler = Cascade()
      .add(
        LoginApi(SecurityServiceImp()).handler,
      )
      .add(
        BlogApi(NoticiaService()).handler,
      )
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(SecurityServiceImp().authorization)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    // address: await CustomEnv.get<String>(key: 'server_address'),
    address: 'localhost',
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
  // port: 8080,
}
