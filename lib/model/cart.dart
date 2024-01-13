class Cart {
  List<CartItem> items = [];
}

class CartItem {
  CartItem({
    required this.menuName,
    required this.quantity,
    required this.normalPrice,
    this.discountPrice,
  });

  final String menuName;
  final int quantity;
  final double normalPrice;
  final double? discountPrice;
}
