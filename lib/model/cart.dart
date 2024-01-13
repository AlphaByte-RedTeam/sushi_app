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

  void clearCart() {
    items = [];
  }

  double get total {
    double total = 0;
    for (var item in items) {
      total += item.quantity * item.normalPrice;
    }
    return total;
  }

  double get discount {
    double discount = 0;
    for (var item in items) {
      if (item.discountPrice != null) {
        discount += item.quantity * item.discountPrice!;
      }
    }
    return discount;
  }

  double get grandTotal {
    return total - discount;
  }

  int get totalItems {
    int totalItems = 0;
    for (var item in items) {
      totalItems += item.quantity;
    }
    return totalItems;
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
