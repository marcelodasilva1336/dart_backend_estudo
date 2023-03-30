import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();
    router.get('/', (Request request) {
      return Response(
        200,
        body: '<h1>Primeira rota</h1>',
        headers: {'content-type': 'text/html'},
      );
    });

    //http://localhost:8080/ola/mundo
    //ola mundo
    router.get('/ola/mundo/<usuario>', (Request req, String usuario) {
      return Response.ok('Ola mundo $usuario');
    });

    //http://localhost:8080/query?nome=deivid
    router.get('/query', (Request req) {
      String? nome = req.url.queryParameters['nome'];
      String? idade = req.url.queryParameters['idade'];
      return Response.ok('Query eh: $nome, idade:$idade');
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['usuario'];
      var senha = json['senha'];

      if (usuario == 'admin' && senha == '123') {
        Map result = {'token': 'token123', 'user_id': 1};
        String jsonResponse = jsonEncode(result);
        return Response.ok(jsonResponse,
            headers: {'content-type': 'application/json'});
      } else {
        return Response.forbidden('Acesso negado!');
      }

      // return Response.ok(json['chave']);
    });

    return router;
  }
}
