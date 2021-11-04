import 'package:listadestinos/models/destination_category_model.dart';
import 'package:listadestinos/screens/destination_form_screen.dart';
import 'package:listadestinos/widgets/grid_image.dart';

import 'destinations_list_screen.dart';
import 'package:flutter/material.dart';

class DestinationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destinos"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _generateGridWidget(
                image: "assets/images/beach.jpg",
                category: DestinationCategory.beaches,
                context: context),
            _generateGridWidget(
                image: "assets/images/cow.jpg",
                category: DestinationCategory.countrysides,
                context: context),
            _generateGridWidget(
                image: "assets/images/egypt.jpg",
                category: DestinationCategory.historicals,
                context: context),
            _generateGridWidget(
                image: "assets/images/mountain.jpg",
                category: DestinationCategory.mountains,
                context: context),
            _generateGridWidget(
                image: "assets/images/orient.jpg",
                category: DestinationCategory.orientals,
                context: context),
            _generateGridWidget(
                image: "assets/images/usa.jpg",
                category: DestinationCategory.occidentals,
                context: context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DestinationFormScreen()),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }

  GestureDetector _generateGridWidget(
      {required String image,
      required DestinationCategory category,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DestinationsListScreen(category: category)));
      },
      child: GridImage(
        image: image,
        description: category.name!,
      ),
    );
  }
}
