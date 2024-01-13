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
    required this.totalPrice,
    required this.hasItem,
  });

  final Cart cart;
  final double totalPrice;
  final bool hasItem;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  MoneyFormatterOutput get fmfNormalTotal {
    return MoneyFormatter(
      amount: widget.totalPrice,
      settings: MoneyFormatterSettings(
        symbol: 'Rp',
        fractionDigits: 0,
        thousandSeparator: '.',
        decimalSeparator: ',',
      ),
    ).output;
  }

  // Use this method to get the normal price for a specific item
  MoneyFormatterOutput getNormalPriceForItem(int index) {
    if (index >= 0 && index < widget.cart.items.length) {
      double normalPrice = widget.cart.items[index].normalPrice;
      return MoneyFormatter(
        amount: normalPrice,
        settings: MoneyFormatterSettings(
          symbol: 'Rp',
          fractionDigits: 0,
          thousandSeparator: '.',
          decimalSeparator: ',',
        ),
      ).output;
    } else {
      // Return an empty MoneyFormatterOutput or handle the case as needed
      return MoneyFormatter(
        amount: 0,
        settings: MoneyFormatterSettings(
          symbol: 'Rp',
          fractionDigits: 0,
          thousandSeparator: '.',
          decimalSeparator: ',',
        ),
      ).output;
    }
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
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.drag_handle_rounded,
                                        color: Colors.grey,
                                      ),
                                      const Gap(16),
                                      Text(
                                        'Order Summary',
                                        style: GoogleFonts.comfortaa(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Gap(16),
                                      Expanded(
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              const Gap(16),
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${widget.cart.items[index].menuName}     x${widget.cart.items[index].quantity}',
                                                  style:
                                                      GoogleFonts.comfortaa(),
                                                ),
                                                Text(
                                                  getNormalPriceForItem(index)
                                                      .symbolOnLeft
                                                      .toString(),
                                                  style:
                                                      GoogleFonts.comfortaa(),
                                                ),
                                              ],
                                            );
                                          },
                                          itemCount: widget.cart.items.length,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total: ',
                                            style: GoogleFonts.comfortaa(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            fmfNormalTotal.symbolOnLeft
                                                .toString(),
                                            style: GoogleFonts.comfortaa(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.deepOrange,
                                                foregroundColor: Colors.white,
                                              ),
                                              child: Text(
                                                'Pay Now',
                                                style: GoogleFonts.comfortaa(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.shopping_cart_checkout_rounded),
                      label: Text(
                        'Check Out',
                        style: GoogleFonts.comfortaa(),
                      ),
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
