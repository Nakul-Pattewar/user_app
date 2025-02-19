import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/features/user/favorite/bloc/favorites_provider.dart';

void main() {
  group('Tests for FavoritesProvider', () {
    late FavoritesProvider favoritesProvider;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      favoritesProvider = FavoritesProvider();
      await favoritesProvider.loadFavorites();
    });

    test(
        'Given favoriteProvider,'
        'When initial state, '
        'Then favorite users list should be empty & showFavorites should be false',
        () {
      expect(favoritesProvider.favoriteUserIds, isEmpty);
      expect(favoritesProvider.showFavorites, isFalse);
    });

    test(
        'Given favoriteProvider,'
        'When toggleFavorite is called,'
        'Then particular user should be added & removed from favorites list',
        () {
      favoritesProvider.toggleFavorite(1);
      expect(favoritesProvider.favoriteUserIds.contains(1), isTrue);
      favoritesProvider.toggleFavorite(1);
      expect(favoritesProvider.favoriteUserIds.contains(1), isFalse);
    });

    test(
        'Given favoriteProvider & showFavorites,'
        'When toggleShowFavorites is called,'
        'Then it should toggle showFavorites value', () {
      final initialShowFavorites = favoritesProvider.showFavorites;
      favoritesProvider.toggleShowFavorites();
      expect(favoritesProvider.showFavorites, !initialShowFavorites);
    });

    test(
        'Given favoriteProvider, '
        'When saveFavorites method called,'
        'Then favorites should be stored in SharedPreferences', () async {
      favoritesProvider.toggleFavorite(2);
      await favoritesProvider.saveFavorites();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('favoriteUserIds'), ['2']);
    });

    test(
        'Given favoriteProvider, '
        'When loadFavorites method called,'
        'Then favorites list should be retrieved from SharedPreferences',
        () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favoriteUserIds', ['3', '4']);

      final newFavoritesProvider = FavoritesProvider();
      await newFavoritesProvider.loadFavorites();

      expect(newFavoritesProvider.favoriteUserIds, containsAll([3, 4]));
    });
  });
}
