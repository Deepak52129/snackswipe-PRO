import 'restaurant.dart';

class TasteProfile {
  int spicePreference;
  int budgetPreference;
  int dessertPreference;
  int vegPreference;

  TasteProfile({
    this.spicePreference = 50,
    this.budgetPreference = 50,
    this.dessertPreference = 50,
    this.vegPreference = 50,
  });

  void updateOnLike(Restaurant r) {
    if (r.tags.contains("spicy")) spicePreference += 3;
    if (r.price > 3) budgetPreference -= 2;
    if (r.tags.contains("dessert")) dessertPreference += 3;
    if (r.tags.contains("veg")) vegPreference += 2;
  }

  void updateOnReject(Restaurant r) {
    if (r.tags.contains("spicy")) spicePreference -= 3;
    if (r.price > 3) budgetPreference += 3;
  }

  /// 🔥 NEW: CALCULATE MATCH SCORE (0–100)
  int compatibilityScore(Restaurant r) {
    int score = 0;

    // spice match
    score += 100 - (spicePreference - r.spiceLevel).abs();

    // budget match
    score += 100 - (budgetPreference - r.price.toInt()).abs();

    // dessert match
    if (r.tags.contains("dessert")) score += dessertPreference;

    // veg match
    if (r.tags.contains("veg")) score += vegPreference;

    return (score / 4).round(); // final score out of 100
  }
}
