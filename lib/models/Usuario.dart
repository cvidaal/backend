// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:backend/services/database.dart';

class Usuario {
  final int? idusuario;
  final String nombre;
  final String password;

  Usuario({
    this.idusuario,
    required this.nombre,
    required this.password,
    });

  Usuario copyWith({
    int? idusuario,
    String? nombre,
    String? password,
  }) {
    return Usuario(
      idusuario: idusuario ?? this.idusuario,
      nombre: nombre ?? this.nombre,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idusuario': idusuario,
      'nombre': nombre,
      'password': password,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idusuario: map['idusuario'] as int?,
      nombre: map['nombre'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Usuario(idusuario: $idusuario, nombre: $nombre, password: $password)';


    // Método para crear un usuario
    Future<int?> insertarUsuarios() async {
    final conn = await Database.conexion();
    try {
      final result = await conn.query('INSERT INTO usuarios (nombre, password) VALUES (?, ?)',
          [nombre, password],);
      return result.insertId;
    } catch (e) {
      print('Error al insertar usuario: $e');
      return null;
    } finally {
      await conn.close();
    }
  }

  Future<bool> comprobar() async {
    final conn = await Database.conexion();
    try {
      var resultado = await conn.query(
        'SELECT * FROM usuarios WHERE nombre = ?',
        [
          nombre,
        ],
      );
      return resultado.isNotEmpty;
    } catch (e) {
      throw Exception('Error al insertar usuario: $e');
    } finally {
      await conn.close();
    }
}

  static Future<List<Usuario>> obtenerUsuarios() async{
      final conn = await Database.conexion();
      try {
        final result = await conn.query('SELECT * FROM usuarios');
        return result.map((row) => Usuario.fromMap(row.fields)).toList(); // Para cada fila accede a los campos de la fila.
      } catch (e) {
        print('Error al obtener usuarios: $e');
        return [];
      } finally {
        await conn.close();
      }
    }

  static Future<Usuario?> obtenerUsuario(int idusuario) async{
      final conn = await Database.conexion();
      try {
        final result = await conn.query('SELECT * FROM usuarios WHERE idusuario = ?', [idusuario]);
        return Usuario.fromMap(result.single.fields);
      } catch (e) {
        print('Error al obtener usuario: $e');
        return null;
      } finally {
        await conn.close();
      }
    }
}