import 'dart:convert';
import 'package:http/http.dart' as http;

class SubscriptionService {
  final String baseUrl = 'http://192.168.56.1:4567/';

  Future<Map<String, dynamic>> createSubscription(Map<String, dynamic> subscriptionData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/suscripcion/crear_suscripcion'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(subscriptionData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); 
    } else {
      throw Exception("Error al crear la suscripción: ${response.body}");
    }
  }
}