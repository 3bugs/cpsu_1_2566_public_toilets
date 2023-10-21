import 'package:collection/collection.dart';
import 'review.dart';

class Toilet {
  final int id;
  final String name;
  final double averageRating;
  final double distance;
  final List<Review> reviews;

  Toilet({
    required this.id,
    required this.name,
    required this.averageRating,
    required this.distance,
    required this.reviews,
  });

  factory Toilet.fromJson(Map<String, dynamic> json) {
    List<Review> reviews =
        json['reviews'].map<Review>((item) => Review.fromJson(item)).toList();
    var averageRating = 0.0;
    if (reviews.isNotEmpty) {
      averageRating = reviews.map((review) => review.rating).average;
    }

    return Toilet(
      id: json['id'],
      name: json['name'],
      averageRating: averageRating,
      distance: json['distance'],
      reviews: reviews,
    );
  }
}
