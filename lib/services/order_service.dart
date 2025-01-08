import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/cart_item_model.dart';
import 'package:e_commerce_app/models/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createOrder({
    required String userId,
    required List<CartItem> items,
    required double totalAmount,
  }) async {
    try {
      final orderRef = _firestore.collection('orders').doc();
      final order = OrderModel(
        id: orderRef.id,
        userId: userId,
        items: items,
        totalAmount: totalAmount,
        status: 'pending',
        orderDate: DateTime.now(),
      );

      await orderRef.set(order.toMap());
      return orderRef.id;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<void> cancelOrder(String orderId, String reason) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': 'cancelled',
        'cancelReason': reason,
      });
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }

  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data()))
            .toList());
  }
}
