import 'dart:convert';
import 'package:flutter/services.dart';

class JsonService {
  Future<Map<String, dynamic>> loadJsonConfig() async {
    final String response = await rootBundle.loadString('assets/config.json');
    return json.decode(response);
  }
}
