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
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        // TODO: continue here
                      },
                      separatorBuilder: (context, index) => const Gap(16),
                      itemCount: data.length,
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
