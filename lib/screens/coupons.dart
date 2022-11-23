import 'package:allpayments/assets/constants.dart';
import 'package:allpayments/components/bottom_section.dart';
import 'package:allpayments/components/title_header.dart';
import 'package:allpayments/provider/route_provider.dart';
import 'package:allpayments/screens/base.dart';
import 'package:allpayments/services/rewe_scraper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponsScreen extends Base {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  final Screen name = Screen.coupons;

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const TitleHeader(
            icon: Icons.discount_outlined,
            title: 'Coupons',
          ),
          SliverToBoxAdapter(
            child: buildBody(),
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                tabs: const [
                  Tab(text: 'Rewe'),
                  Tab(text: 'Lidl'),
                  Tab(text: 'Edeka'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: TabBarView(
                  children: <Widget>[
                    heroCardRow('Rewe'),
                    heroCardRow('Lidl'),
                    heroCardRow('Edeka'),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget reweCouponTile(Map<String, String> coupon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Builder(builder: (context) {
              List<String> text = coupon['title']!.split('je');
              String product = text[0];
              String quant = '';

              if (text.length > 1) {
                quant = text[1];
              }

              return Text.rich(
                TextSpan(text: product, children: [
                  TextSpan(
                    text: quant,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ]),
                softWrap: true,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              );
            }),
          ),
          Text(
            coupon['price']!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget heroCardRow(String market) {
    return Column(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ActionCard(
                active: true,
                heading: '20%',
                type: 'Discount',
                description:
                    'Discount on all $market Brand products.\nAvailable until Tuesday.',
              ),
              ActionCard(
                active: false,
                heading: '10 €',
                type: 'Voucher',
                description: 'For using $market App.',
              ),
            ],
          ),
        ),
        Builder(
            // future: scrapeCoupons(),
            builder: (context) {
          List coupons = [
            {'title': 'Saint Albray L’Original je 180 g', 'price': '1,85€'},
            {'title': 'Chavroux Frischkäse je 150 g', 'price': '1,85€'},
            {'title': 'My Coffee Cup Bio Kaffee je 55 g', 'price': '1,99€'},
            {'title': 'Nergi Kiwibeeren je 125g', 'price': '1,79€'},
            {
              'title':
                  'versch. Sorten Zewa Wisch & Weg Original je 4 x 45 Blatt',
              'price': '1,19€'
            },
            {'title': 'Tulip Bacon in Scheiben je 125 g', 'price': '1,69€'},
            {
              'title': 'Krone Mein Lieblings Bio Lachs je 80 g',
              'price': '2,99€'
            },
            {'title': 'Leibniz Choco Vollmilch je 125 g', 'price': '0,89€'},
            {'title': 'Adidas Geschenkkarte 15-150€ oder 25€', 'price': ''}
          ];

          // if (!snapshot.hasData) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          // List coupons = snapshot.data as List;

          return BottomSection(
            icon: Icons.storefront_outlined,
            title: '$market App Coupons',
            child: Column(
              children: [
                ...coupons.map((coupon) => reweCouponTile(coupon)).toList(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class ActionCard extends StatefulWidget {
  const ActionCard({
    Key? key,
    required this.active,
    required this.description,
    required this.heading,
    required this.type,
  }) : super(key: key);

  final bool active;
  final String description;
  final String heading;
  final String type;

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  Color textColor = Colors.white;
  bool active = true;

  @override
  void initState() {
    super.initState();
    active = widget.active;
    textColor = widget.active ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 210,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: active
                ? cgiPurple.withOpacity(0.2)
                : Colors.black.withOpacity(0.02),
            blurRadius: 30,
            spreadRadius: 3,
            offset: const Offset(10, 15),
          )
        ],
        gradient: active ? cgiGradientPrimary : null,
        color: active ? null : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.discount_outlined,
                color: textColor,
                size: 54,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    widget.heading,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.type,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: textColor,
            height: 34,
          ),
          Text(
            widget.description,
            style: TextStyle(
              color: textColor,
              height: 1.4,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                active ? 'Active' : 'Inactive',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              CupertinoSwitch(
                value: active,
                onChanged: (value) {
                  setState(() {
                    active = value;
                    if (value) {
                      textColor = Colors.white;
                    } else {
                      textColor = Colors.black;
                    }
                  });
                },
                trackColor: textColor.withOpacity(0.3),
                activeColor: textColor.withOpacity(0.3),
              )
            ],
          )
        ],
      ),
    );
  }
}
