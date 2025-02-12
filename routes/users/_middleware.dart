import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(apiKeyMiddleWare);
}

Handler apiKeyMiddleWare(Handler next){
  return (context) async{
    final apiKey = context.request.headers['apiKey'];

    if(apiKey == null && apiKey != '12345'){
      return Response.json(
        statusCode: 401,
        body: jsonEncode('No autorizado'),
      );
    }

    return await next(context);
  };
}
