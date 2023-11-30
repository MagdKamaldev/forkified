// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/colors.dart';

class IngredientListWidget extends StatefulWidget {
  final List<dynamic> ingredients;
  final Function(List<dynamic>) onIngredientsChanged;

  IngredientListWidget({
    required this.ingredients,
    required this.onIngredientsChanged,
  });

  @override
  _IngredientListWidgetState createState() => _IngredientListWidgetState();
}

class _IngredientListWidgetState extends State<IngredientListWidget> {
  TextEditingController ingredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Ingredients',
          style:
              theme.displayLarge!.copyWith(color: isDark! ? cerulian : flame),
        ),
        SizedBox(height: size.height * 0.02),
        TextFormField(
          controller: ingredientController,
          keyboardType: TextInputType.text,
          style: theme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Enter ingredient',
            suffixIcon: IconButton(
              icon: Icon(
                Icons.add,
                color: isDark! ? cerulian : flame,
              ),
              onPressed: () {
                if (ingredientController.text.isNotEmpty) {
                  setState(() {
                    widget.ingredients.add(ingredientController.text);
                    ingredientController.clear();
                    widget.onIngredientsChanged(widget.ingredients);
                  });
                }
              },
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        if (widget.ingredients.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ingredients List:',
                style: theme.bodyMedium,
              ),
              SizedBox(height: size.height * 0.02),
              Wrap(
                spacing: 8,
                children: widget.ingredients
                    .map((ingredient) => Chip(
                          label: Text(ingredient),
                          backgroundColor: isDark! ? platinum : flame,
                          deleteIcon: const Icon(
                            Icons.close,
                          ),
                          onDeleted: () {
                            setState(() {
                              widget.ingredients.remove(ingredient);
                              widget.onIngredientsChanged(widget.ingredients);
                            });
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
      ],
    );
  }
}
