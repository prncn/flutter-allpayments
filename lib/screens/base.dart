import 'package:allpayments/assets/constants.dart';
import 'package:allpayments/screens/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:allpayments/screens/finance_cards.dart';
import 'package:allpayments/screens/coupons.dart';
import 'package:allpayments/screens/home.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          buildNavigationRail(),
          buildScreen(),
        ],
      ),
    );
  }

  Widget buildNavigationRail() {
    return NavigationRail(
      minWidth: 50,
      selectedIconTheme: IconThemeData(color: cgiPurple, size: 22),
      selectedLabelTextStyle: TextStyle(color: cgiPurple),
      groupAlignment: 0,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: NavigationRailLabelType.selected,
      destinations: <NavigationRailDestination>[
        verticalNavigationRailDestination(
            title: 'Coupons', icon: Icons.discount),
        verticalNavigationRailDestination(
            title: 'Shortcuts', icon: FeatherIcons.box),
        verticalNavigationRailDestination(
            title: 'Cards', icon: FeatherIcons.barChart2),
        verticalNavigationRailDestination(
            title: 'Home', icon: FeatherIcons.shoppingBag),
      ],
    );
  }

  NavigationRailDestination verticalNavigationRailDestination({
    required String title,
    required IconData icon,
  }) {
    return NavigationRailDestination(
      icon: Icon(
        icon,
      ),
      selectedIcon: Icon(
        icon,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(title),
        ),
      ),
    );
  }

  Widget buildScreen() {
    return Expanded(
      child: IndexedStack(
        index: _selectedIndex,
        children: const [
          CouponsScreen(),
          ShortcutsScreen(),
          FinanceCardsScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}

class TitleHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? background;

  const TitleHeader({
    Key? key,
    required this.title,
    required this.icon,
    this.background = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: background,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 4),
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onBackground,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onBackground,
                size: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
