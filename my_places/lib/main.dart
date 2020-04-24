import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/places.dart';
import './screens/placesListScreen.dart';
import './screens/addPlaceScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
          value: Places(),
          child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx)=>AddPlaceScreen(),
        },
      ),
    );
  }
}
