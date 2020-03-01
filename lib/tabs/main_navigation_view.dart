import 'package:flutter/material.dart';
import 'package:my_travel_wallet/pages/home_page.dart';
import 'package:my_travel_wallet/tabs/bottom_navigation_bar.dart';
import 'package:my_travel_wallet/tabs/bottom_navigation_bar_button.dart';
import 'package:my_travel_wallet/pages/settings_page.dart';
import 'package:my_travel_wallet/utilities/singleton.dart';

class MainTabView extends StatefulWidget {
  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          Container(
            color: Colors.blue,
          ),
          SettingsPage(),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: [
          CustomBottomNavigationBarButton(icon: Icons.home, function: () => _tabController.index = 0),
          CustomBottomNavigationBarButton(icon: Icons.attach_money, function: () => _tabController.index = 1),
          CustomBottomNavigationBarButton(icon: Icons.settings, function: () => _tabController.index = 2),
        ],
      ),
    );
  }
}

