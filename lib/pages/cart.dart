import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:sushi_app/model/cart.dart';
import 'package:sushi_app/ui/card/item_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    required this.cart,
    required this.normalPrice,
    required this.hasItem,
  });

  final Cart cart;
  final double normalPrice;
  final bool hasItem;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  MoneyFormatterOutput get fmfNormalTotal {
    double total = widget.cart.total;

    return MoneyFormatter(
      amount: total,
      settings: MoneyFormatterSettings(
        symbol: 'Rp',
        fractionDigits: 0,
        thousandSeparator: '.',
        decimalSeparator: ',',
      ),
    ).output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.comfortaa(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.deepOrange,
          ),
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
                    onAdd: () => setState(() {
                      widget.cart.items[index].quantity += 1;
                    }),
                    onDecrease: () => setState(() {
                      if (widget.cart.items[index].quantity > 1) {
                        widget.cart.items[index].quantity -= 1;
                      } else {
                        widget.cart.items.removeAt(index);
                      }
                    }),
                  );
                },
                itemCount: widget.cart.items.length,
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: widget.hasItem == widget.cart.items.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    fmfNormalTotal.symbolOnLeft.toString(),
                    style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/error.svg',
                      height: 180,
                      width: 180,
                    ),
                    const Gap(16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        'Cart Empty. Please add some items to cart.',
                        style: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
