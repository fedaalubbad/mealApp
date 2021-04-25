import 'package:flutter/material.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';
class TabsScreen extends StatefulWidget {
  final  List<Meal>_favoritesMeal;

  TabsScreen(this._favoritesMeal);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPage=0;
  List<Map<String,Object>> _pages;

 @override
 void initState(){
   _pages=[
  {'title':'Categories',
  'page':CategoriesScreen(),
  },
  {'title':'Favorites',
  'page':FavoritesScreen(widget._favoritesMeal),
  },

  ];
   super.initState();

 }

  void _selectPage(int value) {
    setState(() {
      _selectedPage=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(_pages[_selectedPage]['title']) ,
      ),
      body: _pages[_selectedPage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Theme.of(context).primaryColor ,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor:Colors.white ,
        currentIndex: _selectedPage,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category),title: Text('categories')),
          BottomNavigationBarItem(icon: Icon(Icons.star),title: Text('favorites')),
        ],
      ),
      drawer: MainDrawer(),

    );
  }


}
