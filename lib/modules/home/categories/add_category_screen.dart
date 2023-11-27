import 'package:flutter/material.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Category",
          style: theme.displayLarge,
        ),
        toolbarHeight: size.height * 0.08,
      ),
    );
  }
}
