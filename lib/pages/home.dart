import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BannerModel> listBanners = [
    BannerModel(imagePath: 'assets/images/banner-1.png', id: '1'),
    BannerModel(imagePath: 'assets/images/banner-2.png', id: '2'),
    BannerModel(imagePath: 'assets/images/banner-3.png', id: '3'),
  ];

  bool isTakeAway = true;

  List<String> listDelivery = [
    'Take Away',
    'Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              iconColor: MaterialStateColor.resolveWith(
                (states) => Colors.deepOrange,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              iconColor: MaterialStateColor.resolveWith(
                (states) => Colors.deepOrange,
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            Drawer();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            iconColor: MaterialStateColor.resolveWith(
              (states) => Colors.deepOrange,
            ),
          ),
        ),
        title: Text(
          'Shu Shie',
          style: GoogleFonts.comfortaa(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BannerCarousel.fullScreen(
                  animation: true,
                  activeColor: Colors.deepOrange,
                  banners: listBanners,
                  borderRadius: 8,
                  onTap: null,
                  height: 200,
                ),
                const Gap(16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: Colors.grey.withOpacity(0.3),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isTakeAway = true;
                              });
                            },
                            style: ButtonStyle(
                              foregroundColor: isTakeAway
                                  ? MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    )
                                  : MaterialStateProperty.all<Color>(
                                      Colors.black,
                                    ),
                              backgroundColor: isTakeAway
                                  ? MaterialStateColor.resolveWith((states) {
                                      return Colors.deepOrange.shade400;
                                    })
                                  : MaterialStateColor.resolveWith((states) {
                                      return Colors.transparent;
                                    }),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Take Away',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(8),
                                Image.asset(
                                  'assets/images/takeaway.png',
                                  width: 24,
                                  height: 24,
                                  color: isTakeAway ? Colors.white : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isTakeAway = false;
                              });
                            },
                            style: ButtonStyle(
                              foregroundColor: isTakeAway
                                  ? MaterialStateProperty.all<Color>(
                                      Colors.black,
                                    )
                                  : MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                              backgroundColor: isTakeAway
                                  ? MaterialStateColor.resolveWith((states) {
                                      return Colors.transparent;
                                    })
                                  : MaterialStateColor.resolveWith((states) {
                                      return Colors.deepOrange.shade400;
                                    }),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Delivery',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(8),
                                Image.asset(
                                  'assets/images/delivery.png',
                                  width: 24,
                                  height: 24,
                                  color: isTakeAway ? null : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
