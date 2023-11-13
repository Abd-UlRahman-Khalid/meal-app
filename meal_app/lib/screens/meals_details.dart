import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/main.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/favorites_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/filters_provider.dart';

class MealDetailsScreen extends ConsumerWidget{
    const MealDetailsScreen({super.key,required this.meal});

  final Meal meal;


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final FavoritMeals=ref.watch(favoriteMealsProvider);
    final isFavorite=FavoritMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              final wasAdd=ref.
              read(favoriteMealsProvider.notifier).toggleMealFavoviteState(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(wasAdd ? 'Add  to favorites':'removed from favorites')));
            },
            icon:AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8,end: 1).animate(animation),
                  child: child,
                  );
                  },
              child:Icon(
                isFavorite ? Icons.star: Icons.star_border,
                key: ValueKey(isFavorite),
                ),
              ),
            ),
        ],
        title: Text(meal.title)),
        body:SingleChildScrollView(
          child: Column(children: [
            Image.network(
            meal.imageUrl,
            height:250,
            width: double.infinity,
            fit: BoxFit.cover,) ,
            SizedBox(height: 8,),
            Text('ingredient',style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Color.fromARGB(255, 236, 108, 108),
              fontWeight: FontWeight.bold
            )),
            SizedBox(height: 15,),
            for(final ingredient in meal.ingredients )
              Text(ingredient,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white)),
            SizedBox(height: 15,),
            Text('Steps',style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Color.fromARGB(255, 236, 108, 108),
              fontWeight: FontWeight.bold
            )),
            SizedBox(height: 15,),
            for(final steps in meal.steps )
              Padding(
                padding:const  EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 10
                ),
                child: Text(steps,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white)),
              )
          ],),
        )
        
        
      );
      
}
}