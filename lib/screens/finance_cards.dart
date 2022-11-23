import 'package:allpayments/assets/constants.dart';
import 'package:allpayments/components/bottom_section.dart';
import 'package:allpayments/components/title_header.dart';
import 'package:allpayments/provider/route_provider.dart';
import 'package:allpayments/screens/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:allpayments/screens/base.dart';

class FinanceCardsScreen extends Base {
  const FinanceCardsScreen({Key? key}) : super(key: key);

  @override
  final Screen name = Screen.cards;

  @override
  State<FinanceCardsScreen> createState() => _FinanceCardsScreenState();
}

class BottomSectionData {
  final String title;
  final List<Map<String, dynamic>> history;

  const BottomSectionData(this.title, this.history);
}

class _FinanceCardsScreenState extends State<FinanceCardsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  bool _showDetails = false;
  int _selectedCard = 0;

  List<BottomSectionData> detailsData = [
    const BottomSectionData('Credit Payments', [
      {'store': 'St. Marta Teegut', 'amount': 44.4},
      {'store': 'Edeka Eschborn', 'amount': 21.62},
      {'store': 'Greenbelt Deli Square', 'amount': 320.1},
      {'store': 'Rewe Oguz Homburg', 'amount': 17.88},
    ]),
    const BottomSectionData('Debit Payments', [
      {'store': 'Greenbelt Deli Square', 'amount': 320.1},
      {'store': 'Rewe Oguz Homburg', 'amount': 17.88},
      {'store': 'Edeka Eschborn', 'amount': 21.62},
      {'store': 'St. Marta Teegut', 'amount': 44.4},
      {'store': 'St. Marta Teegut', 'amount': 4.4},
    ]),
    const BottomSectionData('Loyalty Card History', [
      {'store': 'Lidl Bad Homburg', 'amount': 44.4},
      {'store': 'Penny Markt', 'amount': 21.62},
      {'store': 'Greenbelt Deli Square', 'amount': 320.1},
    ]),
  ];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1200),
    reverseDuration: const Duration(milliseconds: 400),
    vsync: this,
  );

  late final Animation<double> _detailsAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastLinearToSlowEaseIn,
  );

  void _switchDetails() {
    _showDetails = !_showDetails;

    if (_showDetails) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _closeDetails() {
    _showDetails = false;
    _controller.reverse();
  }

  Widget getBody() {
    return NestedScrollView(
      headerSliverBuilder: ((context, innerBoxIsScrolled) => [
            TitleHeader(
              title: 'Overview',
              icon: FeatherIcons.barChart2,
              background: Theme.of(context).cardColor,
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: const Text(
                'Collect points and buy cheaper!\nJust add your card or create a new one.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            NotificationListener<ScrollNotification>(
              onNotification: (scroll) {
                if (scroll is ScrollStartNotification && _showDetails) {
                  _closeDetails();
                }
                return true;
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCard = 0;
                        });
                        _switchDetails();
                      },
                      child: const FinanceCardDisplay(
                        type: 'Credit Card',
                        logo: 'visa',
                        number: '**** 7547',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCard = 1;
                        });
                        _switchDetails();
                      },
                      child: const FinanceCardDisplay(
                        type: 'Debit Card',
                        logo: 'visa',
                        number: '**** 7547',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCard = 2;
                        });
                        _switchDetails();
                      },
                      child: const FinanceCardDisplay(
                        type: 'Loyalty Card',
                        color: Color(0xff0146ab),
                        logo: 'payback',
                        barcode: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _detailsAnimation,
              axis: Axis.vertical,
              axisAlignment: 1,
              child: BottomSection(
                icon: FeatherIcons.shoppingBag,
                title: detailsData[_selectedCard].title,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Last store',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'Amount',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final List<Map<String, dynamic>> history =
                            detailsData[_selectedCard].history;

                        return DetailsListTile(
                            title: history[index]['store'],
                            subtitle: 'Today at 4:30 pm',
                            trailing:
                                '-${(history[index]['amount'] as double).toStringAsFixed(2)} €');
                      }),
                      separatorBuilder: (context, index) => const Divider(
                        height: 14,
                      ),
                      itemCount: detailsData[_selectedCard].history.length,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FinanceCardDisplay extends StatelessWidget {
  const FinanceCardDisplay({
    Key? key,
    required this.type,
    required this.logo,
    this.number,
    this.color,
    this.barcode = false,
  }) : super(key: key);

  final String type;
  final String logo;
  final String? number;
  final Color? color;
  final bool barcode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            gradient: color == null ? cgiGradientPrimary : null,
            boxShadow: [
              BoxShadow(
                color: darkGray.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 3,
                offset: const Offset(6, 10),
              )
            ]),
        width: 360,
        padding: const EdgeInsets.all(20),
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            if (barcode)
              Center(
                child: Image.asset(
                  'images/barcode.png',
                  height: 120,
                  color: Colors.white,
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (number != null)
                      Text(
                        number!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            letterSpacing: 1),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Valid Thru 08/24',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                  ],
                ),
                Image.asset(
                  'images/$logo-logo.png',
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
