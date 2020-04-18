import 'package:flutter/material.dart';
import '../widgets/mealItem.dart';
import '../dummy_data.dart';

class CategoryMeals extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle)
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
        return MealItem(
        id: categoryMeals.elementAt(index).id,  
        title: categoryMeals.elementAt(index).title,
        imageUrl: categoryMeals.elementAt(index).imageUrl,
        duration: categoryMeals.elementAt(index).duration,
        affordability: categoryMeals.elementAt(index).affordability,
        complexity: categoryMeals.elementAt(index).complexity,
         );
      }, itemCount: categoryMeals.length),
    );
  }
}