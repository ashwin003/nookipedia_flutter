import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Price extends Equatable {
  final int price;
  final String currency;

  const Price(
    this.price,
    this.currency,
  );

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);

  @override
  List<Object?> get props => [
        price,
        currency,
      ];
}
