import 'package:flutter/material.dart';
import 'package:public_toilets/repositories/toilet_repository.dart';
import 'package:public_toilets/utils/ui.dart';

class AddToiletPage extends StatefulWidget {
  const AddToiletPage({super.key});

  @override
  State<AddToiletPage> createState() => _AddToiletPageState();
}

class _AddToiletPageState extends State<AddToiletPage> {
  var _isLoading = false;
  String? _errorMessage;

  final _toiletNameController = TextEditingController();
  final _distanceController = TextEditingController();

  validateForm() {
    return _toiletNameController.text.isNotEmpty &&
        _distanceController.text.isNotEmpty;
  }

  saveToilet() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var toiletName = _toiletNameController.text;
      var distance = double.parse(_distanceController.text);

      await ToiletRepository().addToilet(name: toiletName, distance: distance);

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        showOkDialog(
            context: context,
            title: Text('Error Saving Toilet'),
            content: Text(e.toString()));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    handleClickSave() {
      if (validateForm()) {
        saveToilet();
      } else {
        showOkDialog(
            context: context,
            title: Text('Error'),
            content: Text('Please enter name and distance.'));
      }
    }

    buildForm() => SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _toiletNameController,
                      decoration: InputDecoration(
                          hintText: 'Toilet name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.greenAccent,
                          )))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _distanceController,
                      decoration: InputDecoration(
                          hintText: 'Distance',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.greenAccent,
                          )))),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: handleClickSave,
                      child: Text('SAVE', style: textTheme.bodyLarge),
                    ))
              ],
            )));

    return Scaffold(
        appBar: AppBar(title: Text('ADD TOILET')),
        body: Stack(
          children: [
            buildForm(),
            if (_isLoading) buildLoadingOverlay(),
          ],
        ));
  }
}
