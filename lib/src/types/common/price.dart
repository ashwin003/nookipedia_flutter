import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Price {
  final int price;
  final String currency;

  Price(
    this.price,
    this.currency,
  );

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
