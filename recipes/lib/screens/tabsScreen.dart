import 'package:flutter/material.dart';
import 'package:recipes/screens/favoritesScreen.dart';
import './categoriesScreen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
          appBar: AppBar(
        title: Text('Meals'),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.category), text: 'Categories'),
            Tab(icon: Icon(Icons.star), text: 'Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          CategoriesScreen(),
          FavoritesScreen()
        ],
      ),
      ),
      length: 2,
    );
  }
}
