import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/categories_meals_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  const CategoryItemWidget(this.id,this.title,this.color);

  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(CategoriesMealScreen.routName,
        arguments: {
          'id':id,
          'title':title,
          'color':color,
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient:LinearGradient(colors: [color.withOpacity(0.6),color],begin: Alignment.topLeft,end:Alignment.bottomRight ),
            borderRadius: BorderRadius.circular(15)),

        child: Text(title,style: Theme.of(context).textTheme.title,),  //style from theme in main.dart
      ),
    );
  }
}
