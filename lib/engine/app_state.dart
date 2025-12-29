import '../models/taste_profile.dart';
import '../models/restaurant.dart';

class AppState {
  TasteProfile taste = TasteProfile();
  List<Restaurant> restaurants;

  int swipeCount = 0; // 🔥 NEW — used for filtering after 5 swipes

  AppState(this.restaurants);

  void like(Restaurant r) {
    taste.updateOnLike(r);
    r.popularity += 5;
  }

  void reject(Restaurant r) {
    taste.updateOnReject(r);
    r.popularity -= 3;
  }

  void skip(Restaurant r) {
    r.popularity -= 1;
  }

  void wishlist(Restaurant r) {
    r.popularity += 2;
  }
}
