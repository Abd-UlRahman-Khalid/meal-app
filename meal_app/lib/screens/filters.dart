import 'package:flutter/material.dart';
import 'package:meal_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meal_app/screens/taps.dart';
// import 'package:meal_app/widget/drawer.dart';


class FiltersScreen extends ConsumerStatefulWidget{
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends ConsumerState<FiltersScreen>{
  var _glutenFreeFilterSet=false;
  var _lactuseFreeFilterSet=false;
  var _vegetarianFilterSet=false;
  var _veganFreeFilterSet=false;

  @override
  void initState() {
    super.initState();
    final activeFilter=ref.read(filterProvider);
      _glutenFreeFilterSet=activeFilter[Filter.glutenFree]!;
      _lactuseFreeFilterSet=activeFilter[Filter.lactuseFree]!;
      _vegetarianFilterSet=activeFilter[Filter.vegetarian]!;
      _veganFreeFilterSet=activeFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: DrawerWidget(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if(identifier=='meals'){
      //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const TapsScreen()));
      //   }
      // },),
      body: WillPopScope(
        onWillPop: ()async{
          ref.read(filterProvider.notifier).setFilters({
            Filter.glutenFree:_glutenFreeFilterSet,
            Filter.lactuseFree:_lactuseFreeFilterSet,
            Filter.vegetarian:_vegetarianFilterSet,
            Filter.vegan:_veganFreeFilterSet,
          });
          return  true;
        //   Navigator.of(context).pop({
            
        //   });
        //   return false;
        },
        child: Column(children: [
          SwitchListTile(
            value: _glutenFreeFilterSet,
            onChanged: (isChecked){
              setState(() {
                _glutenFreeFilterSet=isChecked;
              });
            },
            title: Text('Gluten Free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            subtitle: Text('Only includes gluten free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34,right: 22,),
            ),
            SwitchListTile(
            value:_lactuseFreeFilterSet,
            onChanged: (isChecked){
              setState(() {
                _lactuseFreeFilterSet=isChecked;
              });
            },
            title: Text('Lactuse Free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            subtitle: Text('Only includes Lactuse free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34,right: 22,),
            ),
            SwitchListTile(
            value: _vegetarianFilterSet,
            onChanged: (isChecked){
              setState(() {
                _vegetarianFilterSet=isChecked;
              });
            },
            title: Text('vegetarian',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            subtitle: Text('Only includes Lactuse free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34,right: 22,),
            ),
            SwitchListTile(
            value: _veganFreeFilterSet,
            onChanged: (isChecked){
              setState(() {
                _veganFreeFilterSet=isChecked;
              });
            },
            title: Text('vegan',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            subtitle: Text('Only includes Lactuse free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34,right: 22,),
            )
        ],),
      ),
    );
  }
}