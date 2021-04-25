import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/widgets/category_meals_item.dart';
class CategoriesMealScreen extends StatefulWidget {
  static String routName ='/Category_meals_screen';
  final List<Meal> _filteredMeal;

  const CategoriesMealScreen(this._filteredMeal) ;

  @override
  _CategoriesMealScreenState createState() => _CategoriesMealScreenState();

}

class _CategoriesMealScreenState extends State<CategoriesMealScreen> {
  String catTitle, catId;
  Color catColor;
  List<Meal> categoryMealsFilteredList;

  @override
  void didChangeDependencies() {  // تفيد للمتغيرات التي تحوي contrxt تنفذ قبل تنفيذ الwidget  الافضل تعريف المتغيرات فيها
    final routArg=ModalRoute.of(context).settings.arguments as Map<String,Object>;// استقبال arguments
    catId=routArg['id'];
    catTitle=routArg['title'];
    catColor=routArg['color'];
    categoryMealsFilteredList=widget._filteredMeal.where((meal) {   return meal.categories.contains(catId);
    }).toList();
    super.didChangeDependencies();
  }
  // @override
  // void initState() {      // تنفذ قبل تنفيذ الwidget  الافضل تعريف المتغيرات فيها
  //    super.initState();
  // }
  void _removeMeal(String mealId) {
           setState(() {
              categoryMealsFilteredList.removeWhere((meal) => meal.id==mealId);
                  //احذف العنصر الذي يطابق الشرط التالي
           });
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: catColor,
          title: Text(catTitle),
        ),
        body: Container(
          height: double.infinity,
          child: ListView.builder(
            itemBuilder: (ctxt, index) {
              return CategoryMealItem(id:categoryMealsFilteredList[index].id,
                title:categoryMealsFilteredList[index].title,
                image:categoryMealsFilteredList[index].imageUrl,
                duration:categoryMealsFilteredList[index].duration.toString(),
                complexity:categoryMealsFilteredList[index].complexity ,
                affordability:categoryMealsFilteredList[index].affordability,
                removeItem: _removeMeal,
              );
            },
            itemCount:categoryMealsFilteredList.length,
          ),
        ),

      );
  }
}







