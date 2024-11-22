import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String discount;

  const HeaderWidget({required this.title, required this.imageUrl, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(imageUrl),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            discount,
            style: const TextStyle(fontSize: 16, color: Colors.green),
          ),
        ),
      ],
    );
  }
}
