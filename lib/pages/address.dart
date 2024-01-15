import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:sushi_app/helper/supabase_helper.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _stream = SupabaseHelper().fetchAndStreamTable('user_address');
  TextEditingController labelController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  TextEditingController phoneNumReceiverController = TextEditingController();
  RadioGroupController isDefaultAddressController = RadioGroupController();
  bool isDefaultAddress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Address',
          style: GoogleFonts.comfortaa(
            color: Colors.deepOrange,
          ),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                  stream: _stream,
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.data!;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data[index]['label_address'].toUpperCase(),
                                    style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                    ),
                                    onPressed: () {
                                      // TODO: Continue the edit section
                                    },
                                  )
                                ],
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.home,
                                  color: Colors.white,
                                ),
                              ),
                              isThreeLine: true,
                              tileColor: Colors.black.withOpacity(0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${data[index]['receiver_name']} - ${data[index]['receiver_phone_number']}',
                                        style: GoogleFonts.comfortaa(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          try {
                                            SupabaseHelper().deleteFromTable(
                                              'user_address',
                                              data[index]['id'],
                                            );
                                          } catch (e) {
                                            log(e.toString());
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline_rounded,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    data[index]['address'].toUpperCase(),
                                    style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(16),
                        itemCount: data.length,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            useSafeArea: true,
            showDragHandle: true,
            enableDrag: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Tambah Alamat',
                      style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: labelController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Label Alamat *',
                        hintText: 'Contoh: Rumah, Kantor, dll',
                      ),
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Alamat *',
                        hintText: 'Contoh: Jl. ABC Lima Dasar 123 no. 1',
                      ),
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: receiverController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Nama Penerima *',
                        hintText: 'Contoh: Jane Doe',
                      ),
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: phoneNumReceiverController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'No. Telp Penerima *',
                        hintText: 'Contoh: 6287712345678',
                      ),
                    ),
                    const Gap(16),
                    const Text(
                      'Jadikan Alamat Utama?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(16),
                    RadioGroup(
                      controller: isDefaultAddressController,
                      values: const ["Yes", "No"],
                      indexOfDefault: 0,
                      orientation: RadioGroupOrientation.horizontal,
                      onChanged: (value) => value == 'Yes'
                          ? isDefaultAddress = true
                          : isDefaultAddress = false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.comfortaa(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              try {
                                if (labelController.text.isNotEmpty &&
                                    addressController.text.isNotEmpty &&
                                    receiverController.text.isNotEmpty &&
                                    phoneNumReceiverController
                                        .text.isNotEmpty) {
                                  SupabaseHelper().insertToTable(
                                    'user_address',
                                    {
                                      'label_address': labelController.text,
                                      'address': addressController.text,
                                      'receiver_name': receiverController.text,
                                      'receiver_phone_number':
                                          phoneNumReceiverController.text,
                                      'is_default_address': isDefaultAddress,
                                    },
                                  );
                                  Navigator.pop(context);
                                  labelController.clear();
                                  addressController.clear();
                                  receiverController.clear();
                                  phoneNumReceiverController.clear();
                                  log('insert success');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please fill all the fields',
                                        style: GoogleFonts.comfortaa(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              'Save Address',
                              style: GoogleFonts.comfortaa(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
