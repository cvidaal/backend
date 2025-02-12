import 'package:dart_frog/dart_frog.dart';


// onRequest gestiona las peticiones que llegan al servidor
// Este método es de tipo get

// El paso intermedio antes de devolver la petición se llama middleware
// La carpeta routes es donde va a estar la estructura de los endpoints.

Response onRequest(RequestContext context) {
  return Response(body: 'Welcome to Dart Frog!');
}
