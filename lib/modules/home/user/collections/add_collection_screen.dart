// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/collections/collections_cubit.dart';
import 'package:lottie/lottie.dart';

class AddCollectionScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollectionsCubit, CollectionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        TextTheme theme = Theme.of(context).textTheme;
        var cubit = CollectionsCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Add Collection",
                    style: theme.displayLarge!.copyWith(
                      color: isDark! ? platinum : prussianBlue,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  SizedBox(
                      width: size.width * 0.7,
                      height: size.height * 0.3,
                      child: LottieBuilder.asset(isDark!
                          ? "assets/animations/add collection ceriulan.json"
                          : "assets/animations/add collection orange.json")),
                  SizedBox(
                    height: size.height * 0.06,
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
                      label: "Collection Name",
                      prefix: Icons.collections_bookmark_rounded,
                      context: context),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  defaultButton(
                      height: size.height * 0.07,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          cubit.addCollection(
                              name: nameController.text,
                              context: context,
                              theme: theme,
                              size: size);
                        }
                      },
                      context: context,
                      text: "Add Collection"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
