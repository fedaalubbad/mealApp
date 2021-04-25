import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routName = "/MealDetailsScreen";
  final Function toggleFavorite;
  final Function isMealFavorite;

   MealDetailsScreen(this.toggleFavorite, this.isMealFavorite);

  Widget buildSectionTitle (BuildContext ctx,String title){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(title,style: Theme.of(ctx).textTheme.title,),
    );
  }
  Widget buildSectionContainer(Widget child){
    return Container(
      decoration: BoxDecoration(color: Colors.white70,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child:child,
    );
  }
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal=DUMMY_MEALS.firstWhere((meal) =>meal.id==mealId);   //firstWhere  يرجع عنصر واحد اللي بحقق الشرط معناها متى ما كل العنصر في الليست متى ما يتحقق الشرط
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
            ),
            buildSectionTitle(context, 'Ingradients'),
            buildSectionContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildSectionContainer(
              ListView.builder(
                itemBuilder: (ctxt, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(  //تعطي دائرة لكل هيتم توضح رقم الايتم مثلا الخطوات 1 و 2 و ...
                        //اللون الافتراضي للدائرة primry color
                        child: Text('# ${index+1}'),
                      ),
                       title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(),//خط يفصل بين العناصر
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> toggleFavorite(mealId),
        child: Icon(
            isMealFavorite(mealId) ? Icons.star : Icons.star_border),

        // commented remove item
        // onPressed: (){Navigator.of(context).pop(mealId);},
        // child: Icon(Icons.delete),
      ),
    );
  }
}
