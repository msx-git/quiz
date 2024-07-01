import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz/utils/app_routes.dart';
import 'package:quiz/utils/extensions.dart';

import '../../controllers/auth_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigoAccent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Column(
        children: [
          10.height,
          const SafeArea(
            child: SizedBox(
              height: 100,
              child: Icon(
                Icons.person_outline_rounded,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "${FirebaseAuth.instance.currentUser!.email}",
            style: const TextStyle(color: Colors.white),
          ),
          32.height,
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.manageQuiz);
            },
            title: Text(
              "Manage quiz",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            trailing: const Icon(
              CupertinoIcons.chevron_forward,
              color: Colors.white,
            ),
          ),
          12.height,
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.leaderBoard);
            },
            title: Text(
              "Leaderboard",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            trailing: const Icon(
              CupertinoIcons.chevron_forward,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          ListTile(
            onTap: () async {
              context.read<AuthController>().signOut();
            },
            title: Text(
              "Sign Out",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            trailing: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          20.height,
        ],
      ),
    );
  }
}
