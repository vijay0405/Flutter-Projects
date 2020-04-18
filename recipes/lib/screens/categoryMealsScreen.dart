import 'package:flutter/material.dart';
import '../widgets/mealItem.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMeals extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMeals(this.availableMeals);

  @override
  _CategoryMealsState createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: displayedMeals.elementAt(index).id,
                title: displayedMeals.elementAt(index).title,
                imageUrl: displayedMeals.elementAt(index).imageUrl,
                duration: displayedMeals.elementAt(index).duration,
                affordability: displayedMeals.elementAt(index).affordability,
                complexity: displayedMeals.elementAt(index).complexity);
          },
          itemCount: displayedMeals.length),
    );
  }
}
