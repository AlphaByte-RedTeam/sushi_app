import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/helper/supabase_helper.dart';
import 'package:sushi_app/pages/address.dart';
import 'package:sushi_app/ui/screens/login.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  void signOut() async {
    try {
      await SupabaseHelper().client.auth.signOut();
      log('Sign out success!');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Setting',
          style: GoogleFonts.comfortaa(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.deepOrange,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Address',
                    style: GoogleFonts.comfortaa(fontWeight: FontWeight.w600),
                  ),
                  leading: const Icon(Icons.location_on_rounded),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Address(),
                      ),
                    );
                  },
                  iconColor: Colors.deepOrange,
                  textColor: Colors.deepOrange,
                ),
                ListTile(
                  title: Text(
                    'Sign Out',
                    style: GoogleFonts.comfortaa(fontWeight: FontWeight.w600),
                  ),
                  leading: const Icon(Icons.logout_rounded),
                  onTap: () {
                    signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  iconColor: Colors.red,
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
