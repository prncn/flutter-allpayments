import 'package:allpayments/assets/constants.dart';
import 'package:allpayments/components/bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:allpayments/screens/base.dart';

class FinanceCardsScreen extends StatefulWidget {
  const FinanceCardsScreen({Key? key}) : super(key: key);

  @override
  State<FinanceCardsScreen> createState() => _FinanceCardsScreenState();
}

class _FinanceCardsScreenState extends State<FinanceCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FinanceCardDisplay(type: 'Credit Card'),
                  FinanceCardDisplay(type: 'Debit Card'),
                ],
              ),
            ),
            BottomSection(
              icon: FeatherIcons.shoppingBag,
              title: 'History',
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
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      final List<Map<String, dynamic>> history = [
                        {'store': 'St. Marta Teegut', 'amount': 44.4},
                        {'store': 'Edeka Eschborn', 'amount': 21.62},
                        {'store': 'Greenbelt Deli Square', 'amount': 320.1},
                        {'store': 'Rewe Oguz Homburg', 'amount': 17.88},
                      ];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            history[index]['store'],
                            style: TextStyle(color: darkGray.withOpacity(0.6)),
                          ),
                          Text(
                            '${(history[index]['amount'] as double).toStringAsFixed(2)} €',
                            style: TextStyle(color: darkGray.withOpacity(0.6)),
                          ),
                        ],
                      );
                    }),
                    separatorBuilder: (context, index) => const Divider(
                      height: 30,
                    ),
                    itemCount: 4,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
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
    this.logo,
    this.number,
  }) : super(key: key);

  final String type;
  final String? logo;
  final String? number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: cgiGradientPrimary,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '**** 7571',
                      style: TextStyle(
                          color: Colors.white, fontSize: 28, letterSpacing: 1),
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
                  'images/visa-white-shadow.png',
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
