import 'dart:ui';

import 'package:flutter/material.dart';
import './screens/mealDetailScreen.dart';
import './screens/tabsScreen.dart';
import './screens/categoryMealsScreen.dart';
import './screens/categoriesScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
        primarySwatch:Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1 : TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          body2 : TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        )
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx)=>TabsScreen(),
        CategoryMeals.routeName: (ctx)=>CategoryMeals(),
        MealDetail.routeName: (ctx)=>MealDetail()
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      },
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Recipes'),),
//       body: Center(
//         child: Text('Navigation Time')
//       ),
//     );
//   }
// }