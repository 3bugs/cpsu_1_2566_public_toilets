import 'dart:convert';

import 'package:public_toilets/models/toilet.dart';
import 'package:public_toilets/services/api_caller.dart';

class ToiletRepository {
  List<Toilet> toilets = [];

  Future<List<Toilet>> getToilets() async {
    try {
      var result = await ApiCaller().get('toilets?_embed=reviews');
      List list = jsonDecode(result);
      List<Toilet> toiletList =
      list.map<Toilet>((item) => Toilet.fromJson(item)).toList();
      return toiletList;
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
