import 'package:flutter/material.dart';
import 'package:meal_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meal_app/screens/taps.dart';
// import 'package:meal_app/widget/drawer.dart';


class FiltersScreen extends ConsumerWidget{
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeFilters=ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),

      body: Column(children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked){
              ref.read(filterProvider.notifier).setFilter(Filter.glutenFree, isChecked);
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
            value: activeFilters[Filter.lactuseFree]!,
            onChanged: (isChecked){
              ref.read(filterProvider.notifier).setFilter(Filter.lactuseFree, isChecked);
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
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked){
              ref.read(filterProvider.notifier).setFilter(Filter.vegetarian, isChecked);
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
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked){
              ref.read(filterProvider.notifier).setFilter(Filter.vegan, isChecked);
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
      );

  }
}