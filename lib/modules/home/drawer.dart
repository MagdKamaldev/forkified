import 'package:flutter/material.dart';
import 'package:forkified/shared/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: prussianBlue,
    );
  }
}
