import 'package:banner_carousel/banner_carousel.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sushi_app/helper/supabase_helper.dart';
import 'package:sushi_app/model/cart.dart';
import 'package:sushi_app/pages/cart.dart';
import 'package:sushi_app/pages/menu_details.dart';
import 'package:sushi_app/pages/profile.dart';
import 'package:sushi_app/pages/setting.dart';
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

  final Cart cart = Cart();

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

  List<String> categories = [
    'All',
    'New Menu',
    'Paket',
    'Sashimi',
    'Nigiri',
    'Rolls',
    'Ramen',
    'Beverage',
  ];
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Badge(
              label: Text(
                cart.items.length.toString(),
                style: GoogleFonts.comfortaa(
                  color: Colors.white,
                ),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cart: cart,
                    totalPrice: cart.total,
                    hasItem: cart.items.isNotEmpty,
                  ),
                ),
              );
            },
            style: ButtonStyle(
              iconColor: MaterialStateColor.resolveWith(
                (states) => Colors.deepOrange,
              ),
            ),
          ),
          IconButton(
            icon: const Badge(
              label: Text(
                '7',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.notifications_outlined,
              ),
            ),
            onPressed: () {},
            style: ButtonStyle(
              iconColor: MaterialStateColor.resolveWith(
                (states) => Colors.deepOrange,
              ),
            ),
          ),
        ],
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
                  value: categories.indexOf(selectedCategory),
                  onChanged: (val) => setState(() {
                    if (val >= 0 && val < categories.length) {
                      selectedCategory = categories[val];
                    }
                  }),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: categories,
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
                    List filteredData = (selectedCategory == 'All')
                        ? data
                        : data
                            .where((element) =>
                                element['category'] == selectedCategory)
                            .toList();
                    if (filteredData.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/error.svg',
                              width: 200,
                            ),
                            const Gap(16),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                "We don't have any menu for this category. Please come back later.",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Menu(
                                key: ValueKey(filteredData[index]['id']),
                                hasDiscount: filteredData[index]
                                    ['has_discount'],
                                normalPrice: filteredData[index]['sushi_price']
                                    .toDouble(),
                                discountPrice: filteredData[index]
                                        ['discount_price']
                                    .toDouble(),
                                sushiName: filteredData[index]['sushi_name'],
                                sushiRating: filteredData[index]['sushi_rating']
                                    .toDouble(),
                                sushiImage: filteredData[index]['sushi_image'],
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuDetails(
                                      key: ValueKey(filteredData[index]['id']),
                                      menuName: filteredData[index]
                                          ['sushi_name'],
                                      menuImage: filteredData[index]
                                          ['sushi_image'],
                                      category: filteredData[index]['category'],
                                      normalPrice: filteredData[index]
                                              ['sushi_price']
                                          .toDouble(),
                                      discountPrice: filteredData[index]
                                              ['discount_price']
                                          .toDouble(),
                                      description: filteredData[index]
                                          ['description'],
                                      isDiscount: filteredData[index]
                                          ['has_discount'],
                                      cart: cart,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(16),
                        itemCount: filteredData.length,
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
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_circle_sharp,
                      size: 100,
                      color: Colors.white,
                    ),
                    Text(
                      'Jane Dae',
                      style: GoogleFonts.comfortaa(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'Profile',
                  style: GoogleFonts.comfortaa(
                    color: Colors.deepOrange,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.person,
                  color: Colors.deepOrange,
                ),
              ),
              ListTile(
                title: Text(
                  'Setting',
                  style: GoogleFonts.comfortaa(
                    color: Colors.deepOrange,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.settings,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
