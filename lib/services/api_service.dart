import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ui_models.dart';

class ApiService {
  final String apiUrl = "https://dummyjson.com/products";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List productsJson = data['products'];
      return productsJson.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }


  Future<List<Banners>> fetchBanners() async {
    return [
      Banners(imageUrl: "https://cdn.dummyjson.com/products/images/beauty/Powder%20Canister/thumbnail.png"),
      Banners(imageUrl: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"),
      Banners(imageUrl: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"),
      Banners(imageUrl: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"),
    ];
  }

  Future<List<Offer>> fetchOffers() async {
    return [
      Offer(title: "Extra ₹100 off", subtitle: "On SBI Credit Cards"),
      Offer(title: "Flat 15% Off", subtitle: "Use Coupon SAVE15"),
    ];
  }
}








// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/ui_models.dart';
//
// class ApiService {
//   final String baseUrl = 'https://dummyjson.com';
//
//   Future<List<Product>> fetchProducts() async {
//     final response = await http.get(Uri.parse('$baseUrl/products'));
//
//     print("API Response: ${response.body}"); // Debugging log
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final products = (data['products'] as List)
//           .map((item) => Product.fromJson(item))
//           .toList();
//       return products;
//     } else {
//       throw Exception('Failed to load products: ${response.reasonPhrase}');
//     }
//   }
// }
