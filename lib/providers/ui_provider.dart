import 'package:flutter/material.dart';
import '../models/ui_models.dart';
import '../services/api_service.dart';

class UIProvider with ChangeNotifier {
  List<Product>? _products;
  List<Banners>? _banners;
  List<Offer>? _offers;

  List<Product>? get products => _products;
  List<Banners>? get banners => _banners;
  List<Offer>? get offers => _offers;

  Future<void> fetchData() async {
    try {
      final apiService = ApiService();
      _products = await apiService.fetchProducts();
      _banners = await apiService.fetchBanners();
      _offers = await apiService.fetchOffers();
      notifyListeners();
    } catch (error) {
      debugPrint("Error fetching data: $error");
      throw error;
    }
  }
}









// import 'package:flutter/material.dart';
// import '../models/ui_models.dart';
// import '../services/api_service.dart';
//
// class UIProvider with ChangeNotifier {
//   List<Product>? _products;
//
//   List<Product>? get products => _products;
//
//   Future<void> fetchProducts() async {
//     try {
//       final apiService = ApiService();
//       _products = await apiService.fetchProducts();
//       debugPrint("Fetched products: $_products"); // Log products
//       notifyListeners(); // Notify UI of data changes
//     } catch (error) {
//       debugPrint("Error in UIProvider: $error");
//       rethrow; // Rethrow for FutureBuilder to handle
//     }
//   }
// }









// import 'package:flutter/material.dart';
// import '../models/ui_models.dart';
// import '../services/json_service.dart';
//
// class UIProvider with ChangeNotifier {
//   UIConfig? _uiConfig;
//
//   UIConfig? get uiConfig => _uiConfig;
//
//   Future<void> loadUIConfig() async {
//     try {
//       final jsonService = JsonService();
//       final data = await jsonService.loadJsonConfig();
//       _uiConfig = UIConfig.fromJson(data);
//       notifyListeners();
//     } catch (error) {
//       debugPrint("Error loading config: $error");
//     }
//   }
// }
