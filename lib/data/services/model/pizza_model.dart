import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sgmk_test/utils/string_generator.dart';

part 'pizza_model.g.dart';

@JsonSerializable()
class Pizza extends Equatable {
  final String? id;
  final String? title;
  final double? price;
  final int? quantity;
  final bool? inCart;
  final int? maxQuantity;

  Pizza(
      {String? id,
      required this.title,
      required this.price,
      required this.inCart,
      required this.quantity,
      required this.maxQuantity})
      : id = id ?? RandomCodeGenerator.getRandomString();

  Pizza copyWith({
    String? id,
    String? title,
    double? price,
    bool? inCart,
    int? quantity,
    int? maxQuantity,
  }) {
    return Pizza(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        inCart: inCart ?? this.inCart,
        quantity: quantity ?? this.quantity,
        maxQuantity: maxQuantity ?? this.maxQuantity);
  }

  static Pizza fromJson(Map<String, dynamic> json) => _$PizzaFromJson(json);

  Map<String, dynamic> toJson() => _$PizzaToJson(this);

  @override
  List<Object?> get props => [title, price, quantity,id,maxQuantity,inCart];
}
