import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final String status; // 'pending', 'confirmed', 'cancelled', 'delivered'
  final DateTime orderDate;
  final String? cancelReason;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    this.cancelReason,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'orderDate': Timestamp.fromDate(orderDate),
      'cancelReason': cancelReason,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      userId: map['userId'],
      items:
          (map['items'] as List).map((item) => CartItem.fromMap(item)).toList(),
      totalAmount: map['totalAmount'],
      status: map['status'],
      orderDate: (map['orderDate'] as Timestamp).toDate(),
      cancelReason: map['cancelReason'],
    );
  }
}
