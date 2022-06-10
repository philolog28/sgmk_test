// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizza_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pizza _$PizzaFromJson(Map<String, dynamic> json) => Pizza(
      id: json['id'] as String?,
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      inCart: json['inCart'] as bool?,
      quantity: json['quantity'] as int?,
      maxQuantity: json['maxQuantity'] as int?,
    );

Map<String, dynamic> _$PizzaToJson(Pizza instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'quantity': instance.quantity,
      'inCart': instance.inCart,
      'maxQuantity': instance.maxQuantity,
    };
