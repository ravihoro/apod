import 'package:flutter/material.dart';
import 'package:apod/views/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import './image_page.dart';

class HomeView extends StatelessWidget {
  void _changeDate(BuildContext context, HomeViewModel model) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: model.dateTime,
      firstDate: DateTime(1997),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != model.dateTime) {
      model.dateTime = pickedDate;
    }
  }

  Widget _customBottomSheet(BuildContext context, HomeViewModel model) {
    return Container(
      height: 50,
      color: Colors.grey[700],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              'Date: ${model.dateTime == null ? "N/A" : model.dateTime.toIso8601String().substring(0, 10)}',
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              child: Text('Change Date'),
              onPressed: () {
                _changeDate(context, model);
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              child: Text('Find'),
              onPressed: () {
                model.loadImage(model.dateTime);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.loadImage(DateTime.now()),
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: AppBar(
              centerTitle: true,
              title: Text(
                'Astronomy Picture of the Day',
              ),
            ),
          ),
          body: ImagePage(),
          bottomSheet: _customBottomSheet(context, model),
        );
      },
    );
  }
}
