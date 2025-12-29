import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            restaurant.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            restaurant.cuisine,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),

          const SizedBox(height: 10),

          Text("Price: \$${restaurant.price}"),

          const SizedBox(height: 10),

          Text("Tags: ${restaurant.tags.join(', ')}"),

          const SizedBox(height: 10),

          Text("Rating: ${restaurant.rating}/100"),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
