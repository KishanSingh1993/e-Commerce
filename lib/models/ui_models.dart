class Product {
  final String title;
  final String thumbnail;
  final double price;
  final double discountPercentage;

  Product({required this.title, required this.thumbnail, required this.price, required this.discountPercentage});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      thumbnail: json['thumbnail'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
    );
  }
}

class Banners {
  final String imageUrl;

  Banners({required this.imageUrl});

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(imageUrl: json['imageUrl']);
  }
}

class Offer {
  final String title;
  final String subtitle;

  Offer({required this.title, required this.subtitle});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}




// class Header {
//   final String title;
//   final String imageUrl;
//   final String discount;
//
//   Header({required this.title, required this.imageUrl, required this.discount});
//
//   factory Header.fromJson(Map<String, dynamic> json) {
//     return Header(
//       title: json['title'],
//       imageUrl: json['imageUrl'],
//       discount: json['discount'],
//     );
//   }
// }
//
// class Category {
//   final String name;
//   final String icon;
//
//   Category({required this.name, required this.icon});
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       name: json['name'],
//       icon: json['icon'],
//     );
//   }
// }
//
// class Offer {
//   final String title;
//   final String details;
//
//   Offer({required this.title, required this.details});
//
//   factory Offer.fromJson(Map<String, dynamic> json) {
//     return Offer(
//       title: json['title'],
//       details: json['details'],
//     );
//   }
// }
//
// class Deal {
//   final String title;
//   final String price;
//   final String discount;
//   final String imageUrl;
//
//   Deal({required this.title, required this.price, required this.discount, required this.imageUrl});
//
//   factory Deal.fromJson(Map<String, dynamic> json) {
//     return Deal(
//       title: json['title'],
//       price: json['price'],
//       discount: json['discount'],
//       imageUrl: json['imageUrl'],
//     );
//   }
// }
//
// class UIConfig {
//   final Header header;
//   final List<Category> categories;
//   final List<Offer> offers;
//   final List<Deal> deals;
//
//   UIConfig({required this.header, required this.categories, required this.offers, required this.deals});
//
//   factory UIConfig.fromJson(Map<String, dynamic> json) {
//     return UIConfig(
//       header: Header.fromJson(json['header']),
//       categories: (json['categories'] as List).map((e) => Category.fromJson(e)).toList(),
//       offers: (json['offers'] as List).map((e) => Offer.fromJson(e)).toList(),
//       deals: (json['deals'] as List).map((e) => Deal.fromJson(e)).toList(),
//     );
//   }
// }
