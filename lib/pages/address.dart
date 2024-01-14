import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/helper/supabase_helper.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _stream = SupabaseHelper().fetchAndStreamTable('user_address');

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
                                      Icons.edit,
                                    ),
                                    onPressed: () {},
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
                                          Icons.delete,
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
        onPressed: () {},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
