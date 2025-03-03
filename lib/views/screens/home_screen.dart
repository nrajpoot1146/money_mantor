import 'package:flutter/material.dart';
import 'package:money_mantor/views/states/home_screen_state.dart';

import '../widgets/menu_item_button.dart';
import 'khata/persons_list_screen.dart';

class HomeScreen extends HomeScreenStatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(""),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: GridView.count(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 2, // Spacing between columns
        mainAxisSpacing: 2, // Spacing between rows
        padding: const EdgeInsets.all(10), // Padding around the grid
        childAspectRatio:
            1.0, // Width / Height ratio of each item (1.0 = square)
        children: List.generate(
          20, // Number of items
          (index) => CustomMenuItemButton(
            icon: const Icon(Icons.monetization_on),
            ontap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PersonsListScreen(),
                ),
              );
            },
            title: "Name",
          ),
        ),
      ),
    );
  }
}
