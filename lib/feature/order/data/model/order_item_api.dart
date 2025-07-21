import 'package:equatable/equatable.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/entity/order_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_api.g.dart';

@JsonSerializable()
class OrderItemApiModel extends Equatable {
  @JsonKey(name: 'product')
  final String? productId;
  final int? quantity;
  final double? price;
  final String? name;
  final String? imageUrl;

  const OrderItemApiModel({
    this.productId,
    this.quantity,
    this.price,
    this.name,
    this.imageUrl,
  });

  const OrderItemApiModel.empty()
    : productId = '',
      quantity = 0,
      price = 0.0,
      name = '',
      imageUrl = '';

  factory OrderItemApiModel.fromJson(Map<String, dynamic> json) {
    return OrderItemApiModel(
      productId: json['product'],
      quantity: json['quantity'],
      price: (json['price'] as num?)?.toDouble(),
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  OrderItem toEntity() => OrderItem(
    productId: productId ?? '',
    quantity: quantity ?? 0,
    price: price ?? 0.0,
    name: name ?? 'Unnamed Product',
    imageUrl: imageUrl ?? '',
  );

  static OrderItemApiModel fromEntity(OrderItem entity) => OrderItemApiModel(
    productId: entity.productId,
    quantity: entity.quantity,
    price: entity.price,
    name: entity.name,
    imageUrl: entity.imageUrl,
  );

  static List<OrderItem> toEntityList(List<OrderItemApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [productId, quantity, price, name, imageUrl];
}
