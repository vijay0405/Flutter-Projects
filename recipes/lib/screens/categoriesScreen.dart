import 'package:flutter/material.dart';

import '../widgets/categoryItem.dart';
import '../dummy_data.dart';


class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: EdgeInsets.all(25),
        children: DUMMY_CATEGORIES.map((cData)=> CategoryItem(cData.id, cData.title, cData.color)).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200,
        childAspectRatio: 3/2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20
        ), 
      );
  }
}