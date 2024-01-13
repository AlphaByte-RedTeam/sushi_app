import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:sushi_app/model/cart.dart';

class ItemCart extends StatefulWidget {
  ItemCart({
    super.key,
    required this.label,
    required this.normalPrice,
    this.discountPrice,
    required this.image,
    required this.quantity,
    required this.onDecrease,
    required this.onAdd,
  });

  final String label;
  final double normalPrice;
  final double? discountPrice;
  final String image;
  int quantity;
  void Function() onDecrease;
  void Function() onAdd;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  MoneyFormatterOutput get fmfNormal {
    return MoneyFormatter(
      amount: widget.normalPrice,
      settings: MoneyFormatterSettings(
        symbol: 'Rp',
        fractionDigits: 0,
        thousandSeparator: '.',
        decimalSeparator: ',',
      ),
    ).output;
  }

  MoneyFormatterOutput get fmfDiscount {
    return MoneyFormatter(
      amount: widget.discountPrice ?? 0,
      settings: MoneyFormatterSettings(
        symbol: 'Rp',
        fractionDigits: 0,
        thousandSeparator: '.',
        decimalSeparator: ',',
      ),
    ).output;
  }

  final cart = Cart();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.comfortaa(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              fmfNormal.symbolOnLeft.toString(),
              style: GoogleFonts.comfortaa(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const Gap(16),
            Row(
              children: [
                IconButton(
                  onPressed: widget.onDecrease,
                  icon: const Icon(Icons.remove),
                  color: Colors.deepOrange,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  widget.quantity.toString(),
                  style: GoogleFonts.comfortaa(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Gap(8),
                IconButton(
                  onPressed: widget.onAdd,
                  icon: const Icon(Icons.add),
                  color: Colors.deepOrange,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Image.asset(widget.image, width: 150),
      ],
    );
  }
}
