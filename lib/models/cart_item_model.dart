class CartItem {
  final String productId;
  final String imageUrl;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'imageUrl': imageUrl,
      'productName': title,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'],
      imageUrl: map['imageUrl'],
      title: map['productName'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}
