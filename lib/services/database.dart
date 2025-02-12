import 'package:mysql1/mysql1.dart';

abstract class Database {
  static const String _host = 'localhost';
  static const int _port = 3306;
  static const String _user = 'root';

  static Future<MySqlConnection> conexion() async {
    try {
      final settings = ConnectionSettings(
        host: _host,
        port: _port,
        user: _user,
        db: 'backend',
      );
      print('Conectando a la base de datos');
      return await MySqlConnection.connect(settings);
    } catch(e) {
      print('Error al conectar a la base de datos: $e');
      throw Exception('Error al conectar a la base de datos');
    }
  }
}