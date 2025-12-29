import 'package:flutter/material.dart';
import '../models/taste_profile.dart';

class ProfileScreen extends StatelessWidget {
  final TasteProfile taste;

  const ProfileScreen({super.key, required this.taste});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Taste Profile"),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: const Color(0xFFFFF2D5),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Preferences",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildScore("Spice Preference", taste.spicePreference),
            _buildScore("Budget Preference", taste.budgetPreference),
            _buildScore("Dessert Preference", taste.dessertPreference),
            _buildScore("Veg Preference", taste.vegPreference),

            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Back",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScore(String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "$title : $value / 100",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
