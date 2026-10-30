import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  vegetarian,
  vegan,
  lactoseFree,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters[Filter.glutenFree] ?? false;
    _vegetarian = widget.currentFilters[Filter.vegetarian] ?? false;
    _vegan = widget.currentFilters[Filter.vegan] ?? false;
    _lactoseFree = widget.currentFilters[Filter.lactoseFree] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
        ),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) {
            if (didPop) return;
            Navigator.of(context).pop({
              Filter.glutenFree: _glutenFree,
              Filter.lactoseFree: _lactoseFree,
              Filter.vegetarian: _vegetarian,
              Filter.vegan: _vegan,
            });
          },
          child: Column(
            children: [
              SwitchListTile(
                value: _glutenFree,
                onChanged: (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
                title: Text('Gluten-free',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text('Only include gluten-free meals',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
                activeThumbColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
              ),
              SwitchListTile(
                value: _vegetarian,
                onChanged: (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
                title: Text('Vegetarian',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text('Only include vegetarian meals',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
                activeThumbColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
              ),
              SwitchListTile(
                value: _vegan,
                onChanged: (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
                title: Text('Vegan',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text('Only include vegan meals',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
                activeThumbColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
              ),
              SwitchListTile(
                value: _lactoseFree,
                onChanged: (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
                title: Text('Lactose-free',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text('Only include lactose-free meals',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
                activeThumbColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
              ),
            ],
          ),
        ));
  }
}
