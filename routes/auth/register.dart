import 'dart:convert';
import 'package:backend/models/Acceso.dart';
import 'package:backend/models/Usuario.dart';
import 'package:dart_frog/dart_frog.dart';

// Acceso apiKey = Acceso.apiKey(); //  ApiKey declarada en Acceso.dart
Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;

  if(method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      body: jsonEncode({'error': 'Método no permitido'}),
    );
  }

  try {
    final body = await context.request.json() as Map<String, dynamic>;
    final usuario = Usuario.fromJson(jsonEncode(body));

      final existe = await usuario.comprobar();

      if(existe) {
        return Response(
          statusCode: 400,
          body: jsonEncode({'error': 'Usuario ya existe'}),
        );
      } else{
        final idusuario = await usuario.insertarUsuarios();
        await Acceso.insertarAcceso(idusuario!);
        return Response(
          statusCode: 200,
          body: jsonEncode({'mensaje' : 'Usuario registrado con éxito'}),
        );
      }

    } catch(e){
      return Response(
        statusCode: 400,
        body: jsonEncode({'error': 'Error al registrar usuario o acceso'})
      );
    }
  }