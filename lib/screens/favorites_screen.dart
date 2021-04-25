import 'package:flutter/material.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/widgets/category_meals_item.dart';
class FavoritesScreen extends StatelessWidget {
  final  List<Meal>_favoritesMeal;

  FavoritesScreen(this._favoritesMeal);

  @override
  Widget build(BuildContext context) {
    if(_favoritesMeal.isEmpty) {
      return Center(
          child: Text("No Favorites yet"),
        );
    }else{
      return Container(
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (ctxt, index) {
            return CategoryMealItem(id:_favoritesMeal[index].id,
              title:_favoritesMeal[index].title,
              image:_favoritesMeal[index].imageUrl,
              duration:_favoritesMeal[index].duration.toString(),
              complexity:_favoritesMeal[index].complexity ,
              affordability:_favoritesMeal[index].affordability,
              removeItem: (){},
            );
          },
          itemCount:_favoritesMeal.length,
        ),
      );
    }
  }
}
