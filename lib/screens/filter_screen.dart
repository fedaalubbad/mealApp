import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routName = '/filters';
  final Function saveFilters ;
  final Map<String,bool> currentFilter;
  const FilterScreen(this.saveFilters, this.currentFilter);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false; // خالي من الجلوتين
  bool _lactoseFree = false; //خالي من اللاكتوز
  bool _vegan = false; //نباتي: يتجنب تناول كل مشتقات الحيوانات
  bool _vegetarian = false; // نباتي يتجنب تناول اللحوم

  @override
   initState(){  // تحدث القيم قبل بناء الwidgets
     _glutenFree = widget.currentFilter['gluten']; // اسند قيمة جديدة للمتغيرات المحفوظة مسبقا
     _lactoseFree = widget.currentFilter['lactose'];
     _vegan =widget.currentFilter['vegan'];
     _vegetarian = widget.currentFilter['vegetarian'];
     super .initState();
   }
  Widget buildSwitchListTile(
      String title, String subTitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(
          title,
        ),
        value: currentValue,
        subtitle: Text(
          subTitle,
        ),
        onChanged: updateValue
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save,color: Theme.of(context).accentColor,),
            onPressed:(){
              final selectedFilters= {
                'gluten':_glutenFree,
                'lactose':_lactoseFree,
                'vegan':_vegan,
                'vegetarian':_vegetarian,
              };

              widget.saveFilters(selectedFilters);},
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Adjust your meal selection!',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  "Gluten-free",
                  "Only include gluten-free meals.",
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  "Lactose-free",
                  "Only include Lactose-free meals.",
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  "Vegetarian-free",
                  "Only include Vegetarian-free meals.",
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  "Vegan-free",
                  "Only include Vegan-free meals.",
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
