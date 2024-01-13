class Cart {
  List<CartItem> items = [];

  void addToCart(CartItem item) {
    final index =
        items.indexWhere((element) => element.menuName == item.menuName);
    if (index >= 0) {
      items[index].quantity += 1;
    } else {
      items.add(item);
    }
  }

  void removeFromCart(CartItem item) {
    final index =
        items.indexWhere((element) => element.menuName == item.menuName);
    if (index >= 0) {
      if (items[index].quantity > 1) {
        items[index].quantity -= 1;
      } else {
        items.removeAt(index);
      }
    }
  }
}

class CartItem {
  CartItem({
    required this.menuName,
    required this.quantity,
    required this.normalPrice,
    required this.image,
    this.discountPrice,
  });

  final String menuName;
  int quantity;
  final double normalPrice;
  final double? discountPrice;
  final String image;
}
