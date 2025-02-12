// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';
import 'package:backend/services/database.dart';
import 'package:dart_frog/dart_frog.dart';

class Acceso {
  int? idacceso;
  int? idusuario;
  String? token;
  DateTime? expirationDate;

  Acceso({
    required this.idacceso,
    required this.idusuario,
    required this.token,
    required this.expirationDate,
  });

  // Acceso.apiKey({
  //   this.token = '12345',
  // });

  Acceso copyWith({
    int? idacceso,
    int? idusuario,
    String? token,
    DateTime? expirationDate,
  }) {
    return Acceso(
      idacceso: idacceso ?? this.idacceso,
      idusuario: idusuario ?? this.idusuario,
      token: token ?? this.token,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idacceso': idacceso,
      'idusuario': idusuario,
      'token': token,
      'expirationDate': expirationDate?.toIso8601String(),
    };
  }

  factory Acceso.fromMap(Map<String, dynamic> map) {
    return Acceso(
      idacceso: map['idacceso'] as int,
      idusuario: map['idusuario'] as int,
      token: map['token'] as String,
      expirationDate: DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Acceso.fromJson(String source) => Acceso.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Acceso(idacceso: $idacceso, idusuario: $idusuario, token: $token, expirationDate: $expirationDate)';
  }

  // Método para obtener un acceso
  static bool accesoConApiKey(RequestContext context, token) {
    if(context.request.headers['apiKey'] == token){
      return true;
    } else {
      return false;
    }
  }

  static String generarApi() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(8, (index) => characters[random.nextInt(characters.length)]).join();
  }

  static Future<void> insertarAcceso(int idusuario) async {

    final conn = await Database.conexion();
    final token = generarApi();
    final expirationDate = DateTime.now().add(const Duration(hours: 1));

    try {
      final result = await conn.query('INSERT INTO accesos (idusuario, token, expirationDate) VALUES (?, ?, ?)',
          [idusuario, token, expirationDate.toIso8601String()],);
    } catch (e) {
      print('Error al insertar acceso: $e');
    } finally {
      await conn.close();
    }
  }


}
