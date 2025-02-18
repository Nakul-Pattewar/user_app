import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> favoriteUserIds = {};
  bool showFavorites = false;

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteIds = prefs.getStringList('favoriteUserIds');
    if (favoriteIds != null) {
      favoriteUserIds.addAll(favoriteIds.map((id) => int.parse(id)));
    }
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteIds =
        favoriteUserIds.map((id) => id.toString()).toList();
    await prefs.setStringList('favoriteUserIds', favoriteIds);
  }

  void toggleFavorite(int userId) {
    if (favoriteUserIds.contains(userId)) {
      favoriteUserIds.remove(userId);
    } else {
      favoriteUserIds.add(userId);
    }
    saveFavorites();
    notifyListeners();
  }

  void toggleShowFavorites() {
    showFavorites = !showFavorites;
    notifyListeners();
  }
}
