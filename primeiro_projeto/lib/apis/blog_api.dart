import 'dart:convert';

import 'package:primeiro_projeto/models/noticia_model.dart';
import 'package:primeiro_projeto/services/generic_service.dart';
import 'package:primeiro_projeto/services/noticia_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  final GenericService<NoticiaModel> _service;
  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    // listagem
    router.get('/blog/noticias', (Request req) {
      List<NoticiaModel> noticias = _service.findAll();
      return Response.ok(noticias);
    });

    // nova noticia
    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      _service.save(NoticiaModel.fromJson(jsonDecode(body)));
      return Response(201);
    });

    // update
    // /blog/noticia?id=1
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.save('value');

      return Response.ok('Choveu hoje');
    });

    // delete
    // /blog/noticia?id=1
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.delete(1);
      return Response.ok('Choveu hoje');
    });

    return router;
  }
}
