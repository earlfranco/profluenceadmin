import 'package:flutter/material.dart';
import 'package:profluenceadmin/Management.dart';
import 'package:profluenceadmin/ban.dart';
import 'package:profluenceadmin/controller/adminaccess.dart';
import 'package:profluenceadmin/mainpage.dart';

class SideNavigation extends StatefulWidget {
  const SideNavigation({super.key});

  @override
  State<SideNavigation> createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  int page = 0;

  Widget pagedefault() {
    if (page == 0) {
      return const Mainpage();
    } else if (page == 1) {
      return const Management();
    } else if (page == 2) {
      return const BanUser();
    } else {
      return const Mainpage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff23283C),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Drawer(
              backgroundColor: const Color(0xff1A1F32),
              shape: const RoundedRectangleBorder(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 210,
                    child: const DrawerHeader(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "PROFLUENCE",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        page = 0;
                      });
                      debugPrint("$page");
                    },
                    leading: const Icon(
                      Icons.dashboard,
                      size: 46,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        page = 1;
                      });
                      debugPrint("$page");
                    },
                    leading: const Icon(
                      Icons.analytics_rounded,
                      size: 46,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Manage Users",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        page = 2;
                      });
                      debugPrint("$page");
                    },
                    leading: const Icon(
                      Icons.lock_outline_rounded,
                      size: 46,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Ban Users",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Adminaccess()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    leading: const Icon(
                      Icons.logout_outlined,
                      size: 46,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              color: const Color(0xff23283c),
              child: pagedefault(),
            ),
          ),
        ],
      ),
    );
  }
}
