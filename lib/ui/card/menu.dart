import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';

class Menu extends StatefulWidget {
  const Menu({
    super.key,
    required this.hasDiscount,
    required this.normalPrice,
    this.discountPrice,
    required this.sushiName,
    required this.sushiRating,
    required this.sushiImage,
    this.onPressed,
  });

  final bool hasDiscount;
  final double normalPrice;
  final double? discountPrice;
  final String sushiName;
  final double sushiRating;
  final String sushiImage;
  final void Function()? onPressed;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    widget.sushiName,
                    style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  const Gap(4),
                  Text(
                    widget.sushiRating.toString(),
                    style: GoogleFonts.comfortaa(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const Gap(16),
          Image.asset(
            widget.sushiImage,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.hasDiscount
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fmfDiscount.symbolOnLeft,
                          style: GoogleFonts.comfortaa(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          fmfNormal.symbolOnLeft,
                          style: GoogleFonts.comfortaa(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      fmfNormal.symbolOnLeft,
                      style: GoogleFonts.comfortaa(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
              ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.add_shopping_cart),
                label: Text(
                  'Add to Cart',
                  style: GoogleFonts.comfortaa(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
