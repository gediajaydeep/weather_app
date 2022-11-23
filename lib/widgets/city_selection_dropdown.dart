import 'package:flutter/material.dart';
import 'package:open_weather_demo/controllers/city_selection.dart';
import 'package:provider/provider.dart';

class CitySelectionDropDown extends StatelessWidget {
  const CitySelectionDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    CitySelectionController controller =
        context.watch<CitySelectionController>();
    if (controller.availableCity.isEmpty || controller.selectedCity == null) {
      return const Text('Loading');
    }
    return DropdownButton(
      value: controller.selectedCity!,
      items: _createItemsList(controller.availableCity),
      onChanged: (value) {
        controller.selectCity(controller.availableCity.indexOf(value!));
      },
    );
  }

  List<DropdownMenuItem<City>> _createItemsList(List<City> list) {
    return list
        .map((e) => DropdownMenuItem<City>(
              value: e,
              child: Text(e.name),
            ))
        .toList();
  }
}
