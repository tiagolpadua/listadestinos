import 'package:flutter/material.dart';
import 'package:listadestinos/models/destination_category_model.dart';
import 'package:listadestinos/models/destination_model.dart';
import 'package:listadestinos/models/destinations_model.dart';
import 'package:provider/provider.dart';

class DestinationFormScreen extends StatefulWidget {
  @override
  State<DestinationFormScreen> createState() => _DestinationFormScreenState();
}

class _DestinationFormScreenState extends State<DestinationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerName = TextEditingController();
    final TextEditingController _controllerCountry = TextEditingController();
    final TextEditingController _controllerState = TextEditingController();
    final TextEditingController _controllerCity = TextEditingController();
    DestinationCategory? _category;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar destino"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _generateTextFormField(
                    label: "Nome do destino",
                    controller: _controllerName,
                    errorMessage: "Nome inválido!"),
                SizedBox(height: 15),
                _generateTextFormField(
                    label: "País",
                    controller: _controllerCountry,
                    errorMessage: "País inválido!"),
                SizedBox(height: 15),
                _generateTextFormField(
                    label: "Estado",
                    controller: _controllerState,
                    errorMessage: "Estado inválido!"),
                SizedBox(height: 15),
                _generateTextFormField(
                    label: "Cidade",
                    controller: _controllerCity,
                    errorMessage: "Cidade inválido!"),
                SizedBox(height: 15),
                DropdownButtonFormField<DestinationCategory>(
                    value: _category,
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                    isExpanded: true,
                    decoration: InputDecoration(
                        labelText: 'Categoria',
                        labelStyle: TextStyle(
                          color: Colors.deepPurple,
                        )),
                    items: _generateDropDownMenuItems(
                        categories: <DestinationCategory>[
                          DestinationCategory.beaches,
                          DestinationCategory.mountains,
                          DestinationCategory.countrysides,
                          DestinationCategory.occidentals,
                          DestinationCategory.orientals,
                          DestinationCategory.historicals,
                        ]),
                    onChanged: (newCategorySelected) {
                      _category = newCategorySelected;
                    },
                    validator: (value) =>
                        value == null ? "Selecione uma categoria!" : null),
                SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<Destinations>(context, listen: false)
                              .add(Destination(
                            name: _controllerName.text,
                            category: _category!,
                            country: _controllerCountry.text,
                            state: _controllerState.text,
                            city: _controllerCity.text,
                          ));

                          final snackBar = SnackBar(
                              content: Text("Destino salvo com sucesso!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          _controllerName.clear();
                          _controllerCity.clear();
                          _controllerState.clear();
                          _controllerCountry.clear();
                          _category = null;

                          Future.delayed(Duration(seconds: 2),
                              () => Navigator.pop(context));
                        }
                      },
                      child: Text("Salvar destino")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _generateTextFormField(
      {required String label,
      required TextEditingController controller,
      required String errorMessage}) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.deepPurple,
        ),
      ),
      controller: controller,
      validator: (value) => value!.length == 0 ? errorMessage : null,
    );
  }

  List<DropdownMenuItem<DestinationCategory>> _generateDropDownMenuItems(
      {required List<DestinationCategory> categories}) {
    List<DropdownMenuItem<DestinationCategory>> menuItems = [];
    categories.forEach((DestinationCategory element) {
      menuItems.add(DropdownMenuItem<DestinationCategory>(
        child: Text(element.name!),
        value: element,
      ));
    });

    return menuItems;
  }
}
