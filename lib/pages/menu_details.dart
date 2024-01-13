import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';

class MenuDetails extends StatefulWidget {
  const MenuDetails({
    super.key,
    required this.menuName,
    required this.menuImage,
    required this.category,
    required this.description,
    required this.normalPrice,
    this.discountPrice,
  });

  final String menuName;
  final String menuImage;
  final String category;
  final double normalPrice;
  final double? discountPrice;
  final String description;

  @override
  State<MenuDetails> createState() => _MenuDetailsState();
}

class _MenuDetailsState extends State<MenuDetails> {
  final key = GlobalKey<ScaffoldState>();
  bool isFavorite = false;
  bool isRemoveDisable = true;
  int quantity = 1;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            iconColor: MaterialStateColor.resolveWith(
              (states) => Colors.deepOrange,
            ),
          ),
        ),
        title: Text(
          'Detail',
          style: GoogleFonts.comfortaa(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: isFavorite
                ? const Icon(Icons.favorite_border)
                : const Icon(Icons.favorite),
            onPressed: () => setState(() => isFavorite = !isFavorite),
            style: ButtonStyle(
              iconColor: MaterialStateColor.resolveWith(
                (states) => Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.menuName,
                      style: GoogleFonts.comfortaa(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      widget.category,
                      style: GoogleFonts.comfortaa(
                        fontSize: 18,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Gap(16),
                    Image.asset(
                      widget.menuImage,
                      height: 300,
                    ),
                  ],
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          fmfNormal.symbolOnLeft,
                          style: GoogleFonts.comfortaa(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        widget.discountPrice != null
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
                            : const SizedBox(),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99999),
                        border: Border.all(
                          color: Colors.deepOrange,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
                              if (quantity == 1) {
                                isRemoveDisable = true;
                              } else {
                                isRemoveDisable = false;
                              }
                            }),
                            icon: const Icon(Icons.remove),
                            color: isRemoveDisable
                                ? Colors.grey
                                : Colors.deepOrange,
                          ),
                          const Gap(8),
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.comfortaa(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const Gap(8),
                          IconButton(
                            onPressed: () => setState(() {
                              quantity++;
                              isRemoveDisable = false;
                            }),
                            icon: const Icon(Icons.add),
                            color: Colors.deepOrange,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Gap(16),
                Text(
                  'Keterangan',
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const Gap(8),
                Text(
                  widget.description,
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Text(
                  'Add to Cart',
                  style: GoogleFonts.comfortaa(),
                ),
                style: ButtonStyle(
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                      color: Colors.deepOrange,
                      width: 2,
                    ),
                  ),
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.white,
                  ),
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.white,
                ),
                label: Text(
                  'Buy Now',
                  style: GoogleFonts.comfortaa(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
