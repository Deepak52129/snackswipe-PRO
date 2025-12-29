import 'package:flutter/material.dart';
import '../data/mock_restaurants.dart';
import '../widgets/swipe_card.dart';
import '../models/restaurant.dart';
import '../engine/app_state.dart';
import '../screens/profile_screen.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int currentIndex = 0;

  /// 🔥 Our global taste + swipes manager
  late AppState appState;

  @override
  void initState() {
    super.initState();
    appState = AppState(restaurants); // initialize the engine
  }

  /// 🔥 Load next card + apply filtering after 5 swipes
  void nextCard() {
    setState(() {
      appState.swipeCount++;

      // -------------------------
      // 🔥 FILTERING AFTER 5 SWIPES
      if (appState.swipeCount > 5) {

        final filtered = restaurants
            .where((r) => appState.taste.compatibilityScore(r) >= 50)
            .toList();

        if (filtered.isNotEmpty) {
          restaurants = filtered;
          
        } 
        appState.swipeCount = 0; // reset
      }


      // -------------------------
      // NEXT CARD
      // -------------------------
      if (currentIndex < restaurants.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0; // restart after end
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant = restaurants[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFFEED9),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          "SnackSwipe Pro",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProfileScreen(taste: appState.taste), // PASS SCORES 🔥
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: SwipeCard(
          restaurant: restaurant,
          onSwipeComplete: (direction) {
            debugPrint("Swiped: $direction");

            // Update engine
            if (direction == MoveDirection.right) appState.like(restaurant);
            if (direction == MoveDirection.left) appState.reject(restaurant);
            if (direction == MoveDirection.up) appState.wishlist(restaurant);
            if (direction == MoveDirection.down) appState.skip(restaurant);

            // Load next
            nextCard();
          },
        ),
      ),
    );
  }
}
