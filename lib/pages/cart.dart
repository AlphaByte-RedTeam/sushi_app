import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/model/cart.dart';
import 'package:sushi_app/ui/card/item_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cart});

  final Cart cart;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.comfortaa(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Gap(16),
                itemBuilder: (context, index) {
                  return ItemCart(
                    label: widget.cart.items[index].menuName,
                    normalPrice:
                        widget.cart.items[index].normalPrice.toDouble(),
                    image: widget.cart.items[index].image.toString(),
                    quantity: widget.cart.items[index].quantity,
                  );
                },
                itemCount: widget.cart.items.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
