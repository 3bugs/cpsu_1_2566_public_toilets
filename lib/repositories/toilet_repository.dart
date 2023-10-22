import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:public_toilets/models/toilet.dart';
import 'package:public_toilets/services/api_caller.dart';

final toiletProvider = StateNotifierProvider<ToiletRepository, List<Toilet>?>(
    (ref) => ToiletRepository());

class ToiletRepository extends StateNotifier<List<Toilet>?> {
  ToiletRepository() : super(null);

  Future<void> getToilets() async {
    try {
      var result = await ApiCaller().get('toilets?_embed=reviews');
      List list = jsonDecode(result);
      List<Toilet> toiletList =
          list.map<Toilet>((item) => Toilet.fromJson(item)).toList();
      state = toiletList;
    } catch (e) {
      // TODO:
      rethrow;
    }
  }

  Future<void> addToilet(
      {required String name, required double distance}) async {
    try {
      var result = await ApiCaller()
          .post('toilets', params: {'name': name, 'distance': distance});
      await getToilets();
    } catch (e) {
      // TODO:
      rethrow;
    }
  }

  Future<void> addReview(
      {required int toiletId,
      required String review,
      required int rating}) async {
    try {
      var result = await ApiCaller().post('reviews', params: {
        'toiletId': toiletId,
        'userId': 0,
        'review': review,
        'rating': rating
      });
      await getToilets();
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
