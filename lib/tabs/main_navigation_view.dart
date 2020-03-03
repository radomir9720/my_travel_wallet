import 'package:flutter/material.dart';
import 'package:my_travel_wallet/pages/currency_page.dart';
import 'package:my_travel_wallet/pages/home_page.dart';
import 'package:my_travel_wallet/tabs/bottom_navigation_bar.dart';
import 'package:my_travel_wallet/tabs/bottom_navigation_bar_button.dart';
import 'package:my_travel_wallet/pages/settings_page.dart';
import 'package:my_travel_wallet/main.dart';

class MainTabView extends StatefulWidget {
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  _MainTabViewState createState() => _MainTabViewState();
}

List<Widget> pages;
void updatePageStorage(PageStorageKey key, context) {
  pages[key.value] =
      PageStorage.of(context).readState(context, identifier: ValueKey(key));
}

//MySharedPreferences mySharedPreferences = MySharedPreferences();

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Widget _homePage;
  Widget _currencyPage;
  Widget _settingsPage;

  @override
  void initState() {
    super.initState();
//    mySharedPreferences.init();

    _homePage = HomePage(
      key: PageStorageKey(0),
    );
    _currencyPage = CurrencyPage(
      key: PageStorageKey(1),
    );
    _settingsPage = SettingsPage(
      key: PageStorageKey(2),
    );

    pages = [_homePage, _currencyPage, _settingsPage];

    _tabController = TabController(
      initialIndex: 0,
      length: pages.length,
      vsync: this,
    );

    _tabController.addListener(() {
      updatePageStorage(PageStorageKey(_tabController.previousIndex), context);
      pages[_tabController.previousIndex] = PageStorage.of(context).readState(
          context,
          identifier: ValueKey(_tabController.previousIndex));
      setState(() {});
    });

    mySharedPreferences.addListener(() {
      if (this.mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    mySharedPreferences.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: widget.bucket,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: pages,
          controller: _tabController,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: [
          CustomBottomNavigationBarButton(
//            isActive: _tabController.index == 0,
            color: _tabController.index == 0
                ? mySharedPreferences.getThemeAccentColor()
                : mySharedPreferences.getThirdThemeColor(),
            icon: Icons.home,
            function: () => _tabController.index = 0,
          ),
          CustomBottomNavigationBarButton(
              color: _tabController.index == 1
                  ? mySharedPreferences.getThemeAccentColor()
                  : mySharedPreferences.getThirdThemeColor(),
//              isActive: _tabController.index == 1,
              icon: Icons.attach_money,
              function: () => _tabController.index = 1),
          CustomBottomNavigationBarButton(
              color: _tabController.index == 2
                  ? mySharedPreferences.getThemeAccentColor()
                  : mySharedPreferences.getThirdThemeColor(),
//              isActive: _tabController.index == 2,
              icon: Icons.settings,
              function: () => _tabController.index = 2),
        ],
      ),
    );
  }
}
