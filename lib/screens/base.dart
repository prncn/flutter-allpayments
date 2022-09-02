import 'package:allpayments/assets/constants.dart';
import 'package:allpayments/components/dev_comment.dart';
import 'package:allpayments/components/dev_comment_input.dart';
import 'package:allpayments/provider/route_provider.dart';
import 'package:allpayments/provider/theme_provider.dart';
import 'package:allpayments/screens/shortcuts.dart';
import 'package:allpayments/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:allpayments/screens/finance_cards.dart';
import 'package:allpayments/screens/coupons.dart';
import 'package:allpayments/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  final Screen name = Screen.base;

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;
  bool _inputOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 391
        ? Scaffold(
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Builder(builder: (context) {
                    Screen current =
                        Provider.of<RouteProvider>(context, listen: false)
                            .current;
                    return Text(
                      'all payments app v0.1\ncgi\nmvp prototype\nscreen: ${current.name}',
                      style: TextStyle(
                        fontFamily: GoogleFonts.robotoMono().fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('ap-dev-comments')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }
                                  List data = snapshot.data!.docs;
                                  List comments = data
                                      .where((comment) =>
                                          comment['screen'] ==
                                          Provider.of<RouteProvider>(context,
                                                  listen: true)
                                              .current
                                              .name)
                                      .toList();

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) => DevComment(
                                      content: comments[index]['content'],
                                      creator: comments[index]['creator'],
                                      date: comments[index]['date'],
                                      id: comments[index].id,
                                    ),
                                  );
                                }),
                            const SizedBox(height: 20),
                            _inputOpen
                                ? DevCommentInput(
                                    onSubmit: () {
                                      setState(() {
                                        _inputOpen = !_inputOpen;
                                      });
                                    },
                                  )
                                : TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _inputOpen = !_inputOpen;
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                    label: const Text('add comment'),
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 12,
                            blurRadius: 20,
                            offset: const Offset(10, 15),
                          )
                        ]),
                        width: 390,
                        height: 844,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Scaffold(
                            key: Provider.of<ThemeProvider>(context,
                                    listen: false)
                                .scaffoldState,
                            drawerScrimColor: Colors.transparent,
                            drawer: buildNavigationRail(),
                            body: buildScreen(),
                            onDrawerChanged: (value) {
                              ThemeProvider provider =
                                  Provider.of<ThemeProvider>(context,
                                      listen: false);

                              provider.isDrawerOpen = value;

                              value
                                  ? provider.drawerIconController.forward()
                                  : provider.drawerIconController.reverse();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            key: Provider.of<ThemeProvider>(context, listen: false)
                .scaffoldState,
            drawerScrimColor: Colors.transparent,
            drawer: buildNavigationRail(),
            body: buildScreen(),
          );
  }

  Widget buildNavigationRail() {
    return Drawer(
      elevation: 0,
      width: 50,
      child: NavigationRail(
        minWidth: 50,
        selectedIconTheme: IconThemeData(color: cgiPurple, size: 22),
        selectedLabelTextStyle: TextStyle(color: cgiPurple),
        groupAlignment: 0,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          Provider.of<RouteProvider>(context, listen: false).current =
              screens[index].name;
        },
        labelType: NavigationRailLabelType.selected,
        destinations: <NavigationRailDestination>[
          verticalNavigationRailDestination(
            title: 'Coupons',
            selectedIcon: Icons.discount,
            icon: Icons.discount_outlined,
          ),
          verticalNavigationRailDestination(
            title: 'Shortcuts',
            selectedIcon: Icons.dashboard,
            icon: Icons.dashboard_outlined,
          ),
          verticalNavigationRailDestination(
            title: 'Cards',
            selectedIcon: Icons.credit_card,
            icon: Icons.credit_card_outlined,
          ),
          verticalNavigationRailDestination(
            title: 'Home',
            selectedIcon: Icons.shopping_bag,
            icon: Icons.shopping_bag_outlined,
          ),
        ],
      ),
    );
  }

  NavigationRailDestination verticalNavigationRailDestination({
    required String title,
    required IconData icon,
    required IconData selectedIcon,
  }) {
    return NavigationRailDestination(
      icon: Icon(
        icon,
      ),
      selectedIcon: Icon(
        selectedIcon,
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

  List<Base> screens = const [
    CouponsScreen(),
    ShortcutsScreen(),
    FinanceCardsScreen(),
    HomeScreen(),
  ];

  Widget buildScreen() {
    return Stack(
      children: [
        Transform.translate(
          offset: Provider.of<ThemeProvider>(context, listen: true).isDrawerOpen
              ? const Offset(50, 0)
              : Offset.zero,
          child: IndexedStack(
            index: _selectedIndex,
            children: screens,
          ),
        ),
      ],
    );
  }
}
