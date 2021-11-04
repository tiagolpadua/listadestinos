import 'package:flutter/material.dart';
import 'package:listadestinos/models/destination_category_model.dart';
import 'package:listadestinos/models/destinations_model.dart';
import 'package:listadestinos/widgets/destiny_item.dart';
import 'package:provider/provider.dart';

import 'destination_form_screen.dart';

class DestinationsListScreen extends StatelessWidget {
  DestinationCategory category;

  DestinationsListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    bool test = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name!),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<Destinations>(
        builder: (context, information, child) {
          return ListView.builder(
            itemCount: information.destinations.length,
            itemBuilder: (context, int index) {
              if(information.destinations[index].category == category)
                return DestinyListItem(information.destinations[index]);
              return Container();
            });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
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
}
