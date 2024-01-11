import 'package:banner_carousel/banner_carousel.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sushi_app/helper/supabase_helper.dart';
import 'package:sushi_app/ui/card/menu.dart';

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

  List<ValueItem> listAddress = [
    const ValueItem(label: 'Rumah', value: 'Rumah'),
    const ValueItem(label: 'Kantor', value: 'Kantor'),
    const ValueItem(label: 'Kampus', value: 'Kampus'),
  ];
  List<ValueItem> listBranch = [
    const ValueItem(label: 'Koja', value: 'Koja'),
    const ValueItem(label: 'UBM', value: 'UBM'),
    const ValueItem(label: 'Pecenongan', value: 'Pecenongan'),
    const ValueItem(label: 'Sunter', value: 'Sunter'),
    const ValueItem(label: 'Kelapa Gading', value: 'Kelapa Gading'),
  ];
  MultiSelectController selectLocationController = MultiSelectController();
  MultiSelectController selectBranchController = MultiSelectController();

  final _stream = SupabaseHelper().fetchAndStreamTable('sushi');

  int indexSelectedMenu = 0;

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
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerCarousel.fullScreen(
                  animation: true,
                  activeColor: Colors.deepOrange,
                  banners: listBanners,
                  borderRadius: 8,
                  onTap: null,
                  height: 220,
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
                const Gap(16),
                isTakeAway
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isTakeAway
                                ? 'Ambil dari cabang'
                                : 'Dikirim ke alamat',
                            style: GoogleFonts.comfortaa(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.store,
                                            color: Colors.deepOrange,
                                          ),
                                          const Gap(8),
                                          Text(
                                            'Cabang:',
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: MultiSelectDropDown(
                                          onOptionSelected: null,
                                          controller: selectBranchController,
                                          options: listBranch,
                                          selectionType: SelectionType.single,
                                          dropdownHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          showClearIcon: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isTakeAway
                                ? 'Ambil dari cabang'
                                : 'Dikirim ke alamat',
                            style: GoogleFonts.comfortaa(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.deepOrange,
                                          ),
                                          const Gap(8),
                                          Text(
                                            'Lokasi:',
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: MultiSelectDropDown(
                                          onOptionSelected: null,
                                          controller: selectLocationController,
                                          options: listAddress,
                                          selectionType: SelectionType.single,
                                          dropdownHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          showClearIcon: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.store,
                                            color: Colors.deepOrange,
                                          ),
                                          const Gap(8),
                                          Text(
                                            'Cabang:',
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: MultiSelectDropDown(
                                          onOptionSelected: null,
                                          controller: selectBranchController,
                                          options: listBranch,
                                          selectionType: SelectionType.single,
                                          dropdownHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          showClearIcon: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                const Gap(16),
                ChipsChoice.single(
                  value: indexSelectedMenu,
                  onChanged: (val) => setState(() => indexSelectedMenu = val),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: [
                      'All',
                      'New Menu',
                      'Sashimi',
                      'Rolls',
                      'Ramen',
                      'Beverage',
                    ],
                    value: (idx, val) => idx,
                    label: (idx, val) => val,
                  ),
                ),
                const Gap(16),
                StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final data = snapshot.data!;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Menu(
                                hasDiscount: data[index]['has_discount'],
                                normalPrice:
                                    data[index]['sushi_price'].toDouble(),
                                sushiName: data[index]['sushi_name'],
                                sushiRating:
                                    data[index]['sushi_rating'].toDouble(),
                                sushiImage: data[index]['sushi_image'],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(16),
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
