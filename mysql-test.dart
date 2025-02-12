// test_connection.dart
import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '', // Deja vacío si no tienes contraseña configurada en WAMP
    db: 'backend'
  );

  try {
    print('Intentando conectar...');
    final conn = await MySqlConnection.connect(settings);
    print('Conexión exitosa!');
    
    // Intenta una consulta simple
    var results = await conn.query('SELECT 1+1');
    print('Consulta de prueba exitosa: ${results.first[0]}');
    
    // Intenta consultar la tabla usuarios
    results = await conn.query('SELECT COUNT(*) FROM usuarios');
    print('Número de usuarios en la tabla: ${results.first[0]}');
    
    await conn.close();
    print('Conexión cerrada correctamente');
  } catch (e) {
    print('Error durante la prueba: $e');
  }
}
