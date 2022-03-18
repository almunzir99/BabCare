import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/pages/account.dart';
import 'package:babcare/views/pages/discover.dart';
import 'package:babcare/views/pages/favourite.dart';
import 'package:babcare/views/pages/orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class TabsView extends StatefulWidget {
  const TabsView({Key? key}) : super(key: key);

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var drawerController = Get.put(CustomDrawerController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            drawerController.toggleDrawer();
          },
          icon: const Icon(
            LineIcons.bars,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
              height: 25.0,
              width: 30.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Stack(
                children: [
                  //icon
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        LineIcons.bell,
                        color: Colors.black,
                        size: 28.0,
                      )),
                  //badge
                  Positioned(
                    top: 10.0,
                    left: 10.0,
                    child: Container(
                      height: 10.0,
                      width: 10.0,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          DiscoverPage(),
          const FavouritesPage(),
          const OrdersPage(
            hideAppBar: true,
          ),
          AccountPage()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: primaryColor,
              hoverColor: primaryColor,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: primaryColor,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.compass,
                  text: 'تصفح',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'المفضلة',
                ),
                GButton(
                  icon: LineIcons.clipboardList,
                  text: 'طلباتي',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'حسابي',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
