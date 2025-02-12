import 'dart:convert';
import 'package:backend/models/Acceso.dart';
import 'package:backend/models/Usuario.dart';
import 'package:dart_frog/dart_frog.dart';

// Acceso apiKey = Acceso.apiKey();

Future<Response> onRequest(RequestContext context, String id) async{
  switch(context.request.method){

    case HttpMethod.get:
      final usuario = await Usuario.obtenerUsuario(int.parse(id));
      return Response(
        body: jsonEncode(usuario?.toMap()),
      );

    default:
    return Response(
      statusCode: 405,
      body: jsonEncode('Método no permitido')
    );
  }
}