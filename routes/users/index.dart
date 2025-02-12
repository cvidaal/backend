import 'dart:convert';
import 'package:backend/models/Acceso.dart';
import 'package:backend/models/Usuario.dart';
import 'package:dart_frog/dart_frog.dart';

// Acceso apiKey = Acceso.apiKey();

Future<Response> onRequest(RequestContext context) async{
  switch(context.request.method){

    case HttpMethod.get:
      final usuarios = await Usuario.obtenerUsuarios();
      return Response(
        body: jsonEncode(usuarios),
      );

    case HttpMethod.post: // Envian los campos de un formulario y tenemos que recogerlos
      final headers = context.request.headers;
      final body = await context.request.json();
      return Response(body:jsonEncode({'Método': 'Post'}));

    case HttpMethod.put:
      final headers = context.request.headers;
      final body = context.request.json();
      return Response(body:jsonEncode({'Método': 'PUT'}));

    case HttpMethod.delete:
      final headers = context.request.headers;
      final body = context.request.json();
      return Response(body:jsonEncode({'Método': 'Delete'}));
    default:
    return Response(statusCode: 405, body: jsonEncode('Método no permitido'));
  }
}
