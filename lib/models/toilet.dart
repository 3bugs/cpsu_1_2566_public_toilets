import 'package:collection/collection.dart';
import 'review.dart';

class Toilet {
  final int id;
  final String name;
  final double distance;
  final double averageRating;
  final List<Review> reviews;

  Toilet({
    required this.id,
    required this.name,
    required this.distance,
    required this.averageRating,
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
      distance: json['distance'],
      averageRating: averageRating,
      reviews: reviews,
    );
  }

/*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'distance': distance,
      'averageRating': averageRating,
      'reviews': reviews,
    };
  }*/
}
