import 'package:flutter/material.dart';
import 'package:public_toilets/models/toilet.dart';
import 'package:public_toilets/repositories/toilet_repository.dart';
import 'package:public_toilets/screens/home/toilet_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Toilet>? _toilets;
  var _isLoading = false;
  String? _errorMessage;
  final _toiletNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getToilets();
  }

  getToilets() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var toilets = await ToiletRepository().getToilets();
      debugPrint('Number of toilets: ${toilets.length}');

      setState(() {
        _toilets = toilets;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    buildError() => Center(
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_errorMessage ?? '', textAlign: TextAlign.center),
              SizedBox(height: 32.0),
              ElevatedButton(onPressed: getToilets, child: Text('Retry'))
            ])));

    buildList() => ListView.builder(
        itemCount: _toilets!.length,
        itemBuilder: (ctx, i) {
          Toilet toilet = _toilets![i];
          return ToiletListItem(toilet: toilet);
        });

    return Scaffold(
        appBar: AppBar(
          title: Text('Public Toilets'),
        ),
        body: Stack(
          children: [
            if (_toilets?.isNotEmpty ?? false) buildList(),
            if (_errorMessage != null) buildError(),
            if (_isLoading) buildLoadingOverlay()
          ],
        ));
  }
}

/*
Container(
  padding: EdgeInsets.all(16.0),
  child: Column(children: [
    TextField(
        controller: _toiletNameController,
        decoration: InputDecoration(
            hintText: 'ชื่อห้องน้ำ',
            border: OutlineInputBorder(
                borderSide: BorderSide(
              width: 3,
              color: Colors.greenAccent,
            )))),
    Row(children: [
      Expanded(
          child: TextField(
              decoration: InputDecoration(
                  hintText: 'ให้คะแนน',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 3,
                    color: Colors.greenAccent,
                  ))))),
      Expanded(
          child: TextField(
              decoration: InputDecoration(
                  hintText: 'ระยะทาง',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 3,
                    color: Colors.greenAccent,
                  )))))
    ]),
    Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            /*var toiletName = _toiletNameController.text;
          var toilet = Toilet(
            name: toiletName,
            averageRating: 5.0, // todo: homework
            distance: 100.0, // todo: homework
          );

          setState(() {
            ToiletRepository.toilets!.add(toilet);
          });

          _toiletNameController.clear();*/
          },
          child: Text('ADD'),
        ))
  ]))
* */
