import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/mealItem.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(child: Text('You have no favorites yet!'));
    } else {
      return ListView.builder(itemBuilder: (ctx, index) {
        return MealItem(
        id: favoriteMeals.elementAt(index).id,  
        title: favoriteMeals.elementAt(index).title,
        imageUrl: favoriteMeals.elementAt(index).imageUrl,
        duration: favoriteMeals.elementAt(index).duration,
        affordability: favoriteMeals.elementAt(index).affordability,
        complexity: favoriteMeals.elementAt(index).complexity,
         );
      }, itemCount: favoriteMeals.length);
    }
  }
}
