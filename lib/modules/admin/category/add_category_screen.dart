// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/categories/categories_cubit.dart';

class AddCategory extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = CategoriesCubit.get(context);
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is AddCategorySuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add Category",
              style: theme.displayLarge,
            ),
            toolbarHeight: size.height * 0.08,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        onSubmit: () {},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Name must not be empty";
                          }
                        },
                        label: "Category Name",
                        prefix: Icons.category,
                        context: context),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    defaultFormField(
                        controller: descriptionController,
                        type: TextInputType.name,
                        onSubmit: () {},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Description must not be empty";
                          }
                        },
                        label: "Category Description",
                        prefix: Icons.description,
                        context: context),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    Text(
                      "Image",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.getCategoryImagefromGallery(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: isDark! ? cerulian : flame, width: 2),
                        ),
                        child: Center(
                          child: cubit.pickedFile == null
                              ? Text(
                                  'Add +',
                                  style: theme.bodyLarge!.copyWith(
                                      color: isDark! ? cerulian : flame,
                                      fontSize: 20),
                                )
                              : Icon(Icons.done,
                                  color: isDark! ? cerulian : flame),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate() &&
                  cubit.pickedFile != null) {
                cubit.addCategory(
                    name: nameController.text,
                    description: descriptionController.text);
              }
            },
            child: Container(
              height: size.height * 0.1,
              color: isDark! ? cerulian : flame,
              child: Center(
                  child: state is AddCategoryLoading
                      ? CircularProgressIndicator(
                          color: platinum,
                        )
                      : Text("Add", style: theme.displayLarge)),
            ),
          ),
        );
      },
    );
  }
}
