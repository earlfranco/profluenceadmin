import 'package:flutter/material.dart';
import 'package:profluenceadmin/Management.dart';
import 'package:profluenceadmin/mainpag.dart';

class SideNavigation extends StatefulWidget {
  const SideNavigation({super.key});

  @override
  State<SideNavigation> createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  @override
  Widget build(BuildContext context) {
    int page = 0;

    Widget pagedefault() {
      if (page == 0) {
        return const Mainpage();
      } else if (page == 1) {
        return const Management();
      } else {
        return const Mainpage();
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xff23283C),
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        setState(() {
                          page = 0;
                        });
                      },
                      leading: const Icon(Icons.dashboard),
                      title: const Text("Dashboard"),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          page = 1;
                        });
                      },
                      leading: const Icon(Icons.analytics_rounded),
                      title: const Text("Management"),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 10,
              child: Container(
                  color: const Color(0xfff23283c), child: pagedefault()))
        ],
      ),
    );
  }
}
