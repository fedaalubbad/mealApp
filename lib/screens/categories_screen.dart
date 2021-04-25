import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/widgets/category_item.dart';
class CategoriesScreen extends StatelessWidget {
  static String routName='/categoriesScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Meal',
      //          style: Theme.of(context).textTheme.title,),),
      body: Container(
        child: GridView(
          padding: EdgeInsets.all(25.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, //عرض العنصر
            childAspectRatio: 3/2,// نسبة طول العنصر للعرض
            crossAxisSpacing: 20,// المسافة بين العناصر بالعرض
            mainAxisSpacing: 20,// المسافة بين العناصر بالطول
          ),
          children: DUMMY_CATEGORIES.map((catData) =>
          // Container(
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //   gradient:LinearGradient(colors: [catData.color.withOpacity(0.6),catData.color])),
          //   child: Text(catData.title),
          // ),
            CategoryItemWidget(catData.id,catData.title,catData.color),
          ).toList(),


        ),
      ),
    );
  }
}
