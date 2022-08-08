import 'package:allpayments/assets/constants.dart';
import 'package:allpayments/components/bottom_section.dart';
import 'package:allpayments/screens/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);

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
                indicatorColor: cgiPurple,
                labelColor: cgiPurple,
                unselectedLabelColor: darkGray,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Active'),
                  Tab(text: 'Inactive'),
                ],
              ),
              SizedBox(
                height: 400,
                child: TabBarView(
                  children: <Widget>[
                    heroCardRow(),
                    heroCardRow(),
                    heroCardRow(),
                  ],
                ),
              )
            ],
          ),
        ),
        BottomSection(
          icon: Icons.storefront_outlined,
          title: 'Recent Discoveries',
          child: Column(
            children: [
              shopsNearTile(),
              shopsNearTile(),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tabBarSection() {
    return const TabBar(tabs: <Tab>[
      Tab(
        text: 'All',
      ),
      Tab(
        text: 'Active',
      ),
      Tab(
        text: 'Inactive',
      ),
    ]);
  }

  Widget shopsNearTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Friesen - Wolff',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '6488 Greenfelder Islands, MS, KN',
                style: TextStyle(
                  height: 1.8,
                  fontSize: 12,
                  color: darkGray.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Text(
            '~100m',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: darkGray.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView heroCardRow() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          ActionCard(
            active: true,
            heading: '20%',
            type: 'Discount',
            description: 'Ultimate Discount for all customers.\nCross country.',
          ),
          ActionCard(
            active: false,
            heading: '50zl',
            type: 'Voucher',
            description: 'For creating an account within an app.',
          ),
        ],
      ),
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
