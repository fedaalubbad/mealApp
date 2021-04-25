import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/screens/meal_details_screen.dart';

class CategoryMealItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final String duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;

  const CategoryMealItem({
      @required this.id,
      @required this.title,
      @required this.image,
      @required this.duration,
      @required this.complexity,
      @required this.affordability,
      @required this.removeItem,
      });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Shallenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
        break;
    }
  }
  String get affordabilityText {
    switch (affordability) {
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  void selectMeal(BuildContext ctx){
    Navigator.of(ctx).pushNamed(MealDetailsScreen.routName,
    arguments: id
        ).then((result) {
          if(result!=null) removeItem(result);
    });
    }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
      onTap: ()=>selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(//ترتب العناصر فوق بعض
              children: [
                ClipRRect(    //تجبر الصورة ان تاخذ بوردر
                   borderRadius:BorderRadius.only(topLeft:Radius.circular(15),topRight: Radius.circular(15)),
                    child: Image.network(image,fit: BoxFit.cover,width: double.infinity,)
                ),

               Positioned( //لوضع العنصر في مكان محدد
                 right: 10,
                 bottom: 20,
                 child: Container(
                   width: 250,
                   padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
                   color:Colors.black54,
                   child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      ),
                 ),
               ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 8,),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 8,),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 8,),
                      Text(affordabilityText),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
