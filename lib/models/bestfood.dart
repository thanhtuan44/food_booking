import 'package:flutter/material.dart';

class BestFood {
  String name;
  String imageUrl;
  String rating;
  String numberOfRating;
  String price;
  String slug;

  BestFood(
      {Key key,
        @required this.name,
        @required this.imageUrl,
        @required this.rating,
        @required this.numberOfRating,
        @required this.price,
        @required this.slug});
}
List<BestFood> arrBestFoods = [
  BestFood(
      name: "Fried Egg",
      imageUrl: "ic_best_food_8",
      rating: '4.9',
      numberOfRating: '200',
      price: '15.06',
      slug: "fried_egg"),
  BestFood(
      name: "Mixed vegetable",
      imageUrl: "ic_best_food_9",
      rating: "4.9",
      numberOfRating: "100",
      price: "17.03",
      slug: ""),
  BestFood(
      name: "Salad with chicken meat",
      imageUrl: "ic_best_food_10",
      rating: "4.0",
      numberOfRating: "50",
      price: "11.00",
      slug: ""),
  BestFood(
      name: "New mixed salad",
      imageUrl: "ic_best_food_5",
      rating: "4.00",
      numberOfRating: "100",
      price: "11.10",
      slug: ""),
  BestFood(
      name: "Red meat with salad",
      imageUrl: "ic_best_food_1",
      rating: "4.6",
      numberOfRating: "150",
      price: "12.00",
      slug: ""),
  BestFood(
      name: "New mixed salad",
      imageUrl: "ic_best_food_2",
      rating: "4.00",
      numberOfRating: "100",
      price: "11.10",
      slug: ""),
  BestFood(
      name: "Potato with meat fry",
      imageUrl: "ic_best_food_3",
      rating: "4.2",
      numberOfRating: "70",
      price: "23.0",
      slug: ""),
  BestFood(
      name: "Fried Egg",
      imageUrl: "ic_best_food_4",
      rating: '4.9',
      numberOfRating: '200',
      price: '15.06',
      slug: "fried_egg"),
  BestFood(
      name: "Red meat with salad",
      imageUrl: "ic_best_food_5",
      rating: "4.6",
      numberOfRating: "150",
      price: "12.00",
      slug: ""),
  BestFood(
      name: "Red meat with salad",
      imageUrl: "ic_best_food_6",
      rating: "4.6",
      numberOfRating: "150",
      price: "12.00",
      slug: ""),
  BestFood(
      name: "Red meat with salad",
      imageUrl: "ic_best_food_7",
      rating: "4.6",
      numberOfRating: "150",
      price: "12.00",
      slug: ""),
];