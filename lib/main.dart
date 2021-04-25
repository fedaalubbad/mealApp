import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/screens/categories_meals_screen.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() =>_MyAppState();
  }

  class _MyAppState extends State<MyApp> {
    Map<String,bool>_filers={
      'gluten':false,
      'lactose':false,
      'vegan':false,
      'vegetarian':false,
    };
    List<Meal> _filteredMeal=DUMMY_MEALS;
    void _setFilters(Map<String,bool> _filterData){
      setState(() {
        _filers=_filterData;
         _filteredMeal=DUMMY_MEALS.where((meal) {
          if(_filers['gluten']&& meal.isGlutenFree==false) {  //يعني لا يرجع الميل  الشرط الاول ثبت الاول وانفي الثاني
            return false;
          }
          if(_filers['lactose']&& !meal.isLactoseFree) {  //يعني لا يرجع الميل  الشرط الاول ثبت الاول وانفي الثاني
            return false;
          }
          if(_filers['vegetarian']&& !meal.isVegetarian) {  //يعني لا يرجع الميل  الشرط الاول ثبت الاول وانفي الثاني
            return false;
          }
          if(_filers['vegan']&& !meal.isVegan) {  //يعني لا يرجع الميل  الشرط الاول ثبت الاول وانفي الثاني
            return false;
          }
          return true;   // ارجع بخلاف الشروط يقوم بارجاع باقي الوجبات
        }).toList();
      });
    }
    List<Meal> _favoritesMeal=[];
    //تتحقق من وجود الوجبة في قائمة الوجبات
     void _toggleFavorite(String mealId){ //
       setState(() {
         final existingIndex= _favoritesMeal.indexWhere((meal) => meal.id==mealId);   //تمر على كل عنصر وتبحث عن عنصر مطابق للشرط وكل عنصر مطابق ترجع الاندكس الخاص به
         if(existingIndex>=0){
           _favoritesMeal.removeAt(existingIndex);
         }else{
           // عدم تحقق الشرط يرجع -1
           // نضيف العنصر لقائمة المفضلة
           _favoritesMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
         }
       });

     }
     bool _isFavoriteMeal(String id){
       //  دالة ترجع قيمة bool
       return _favoritesMeal.any((meal) => meal.id==id);
     }


    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 244, 210, 1), // لون خلفية الشاشة الافتراضي
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(color:Color.fromRGBO(20, 50, 50, 1),fontSize: 14 ),
          body2: TextStyle(color:Color.fromRGBO(20, 50, 60, 1) ,fontSize: 12),
          title: TextStyle(color:Color.fromRGBO(20, 20, 50, 1) ,fontSize: 20,
              fontFamily: 'RobotoCondensed',fontWeight: FontWeight.bold),
          subtitle: TextStyle(color:Color.fromRGBO(0, 0, 50, 0.6) ,fontSize: 18,fontFamily: 'Raleway'),

        ),
      ),
      debugShowCheckedModeBanner: false,
      // home: MyHomePage(),
      // home: CategoriesScreen(),
      routes:{
        '/':(context)=>TabsScreen(_favoritesMeal),
        CategoriesScreen.routName:(context)=>CategoriesScreen(),
        CategoriesMealScreen.routName:(context)=>CategoriesMealScreen(_filteredMeal),
        MealDetailsScreen.routName:(context)=>MealDetailsScreen(_toggleFavorite,_isFavoriteMeal),
        FilterScreen.routName:(context)=>FilterScreen(_setFilters,_filers)
      },
    );
  }


}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal App'),
      ),
      body:CategoriesScreen(),
    );
  }
}
