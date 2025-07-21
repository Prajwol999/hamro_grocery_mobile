import 'package:equatable/equatable.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/model/user_api_model.dart';
import 'package:hamro_grocery_mobile/feature/order/data/model/order_item_api.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/entity/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model_api.g.dart';

@JsonSerializable()
class OrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? orderId;
  final String? customer;
  final List<OrderItemApiModel>? items;
  final double? amount;
  final String? address;
  final String? phone;
  final String? status;
  final String? paymentMethod;
  final String? transactionId;
  final int? pointsAwarded;
  final bool? discountApplied;
  final String? createdAt;
  final String? updatedAt;

  const OrderApiModel({
    this.orderId,
    this.customer,
    this.items,
    this.amount,
    this.address,
    this.phone,
    this.status,
    this.paymentMethod,
    this.transactionId,
    this.pointsAwarded,
    this.discountApplied,
    this.createdAt,
    this.updatedAt,
  });

  const OrderApiModel.empty() : this(orderId: '', items: const []);

  factory OrderApiModel.fromJson(Map<String, dynamic> json) {
    final dynamic customerData = json['customer'];
    String? customerId;
    if (customerData is String) {
      customerId = customerData;
    } else if (customerData is Map<String, dynamic>) {
      // Handle cases where the API might sometimes send a full object
      customerId = customerData['_id'];
    }
    return OrderApiModel(
      orderId: json['_id'],
      customer: customerId ,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) =>
                    OrderItemApiModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
      amount: (json['amount'] as num?)?.toDouble(),
      address: json['address'],
      phone: json['phone'],
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      transactionId: json['transactionId'],
      pointsAwarded: json['pointsAwarded'],
      discountApplied: json['discountApplied'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  /// Converts the API model to a clean, non-nullable Domain Entity.
  /// This is the primary method used after fetching data from the API.
  OrderEntity toEntity() {
    // Helper to map string to OrderStatus enum safely
    OrderStatus _statusFromString(String? status) {
      return OrderStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => OrderStatus.Processing, // Fallback for safety
      );
    }

    return OrderEntity(
      id: orderId ?? '',
      customerId: customer ?? '' ,
      items: items != null ? OrderItemApiModel.toEntityList(items!) : [],
      amount: amount ?? 0.0,
      address: address ?? '',
      phone: phone ?? '',
      paymentMethod: paymentMethod ?? 'COD',
      status: _statusFromString(status),
      pointsAwarded: pointsAwarded ?? 0,
      discountApplied: discountApplied ?? false,
      createdAt:
          createdAt != null ? DateTime.parse(createdAt!) : DateTime.now(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

OrderApiModel fromEntity(OrderEntity entity) {
  return OrderApiModel(
    orderId: entity.id,
    customer: entity.customerId,
    items:
        entity.items
            .map((itemEntity) => OrderItemApiModel.fromEntity(itemEntity))
            .toList(),
    amount: entity.amount,
    address: entity.address,
    phone: entity.phone,
    status: entity.status.name,
    pointsAwarded: entity.pointsAwarded,
    discountApplied: entity.discountApplied,
  );
}

/// Converts a list of API models to a list of Domain Entities.
List<OrderEntity> toEntityList(List<OrderApiModel> models) =>
    models.map((model) => model.toEntity()).toList();
