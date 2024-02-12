import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              const SliverAppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                title: Text("Activity", style: TextStyle(color: Colors.white)),
              ),
              SliverAppBar(
                shape: const ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(35)),
                ),
                backgroundColor: Colors.black,
                pinned: true,
                automaticallyImplyLeading: false,
                elevation: 10,
                title: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  dividerColor: Colors.transparent,
                  indicator: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.only(top: 20),
                  tabs: [
                    _getTabBar("History"),
                    _getTabBar("InProgress"),
                    _getTabBar("Favorites"),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(children: [
            OrderHistoryList(),
            OrderHistoryList(),
            OrderHistoryList(),
          ]),
        ),
      ),
    );
  }

  Widget _getTabBar(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Center(child: Text(title)),
    );
  }
}

class OrderHistoryList extends StatelessWidget {
  const OrderHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 3,
                (context, i) {
                  return const OrderListItem();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
          const BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 30),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Online Retail Store",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "#DA865DA2679",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Luggage Spot",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Quote Requested 14th January 2024",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  _getStatusItem("Quote Sent", Colors.green),
                  const SizedBox(height: 5),
                  _getStatusItem("View Details", Colors.grey[200]!),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          _getTimeLocation(
            Icons.calendar_month,
            DateFormat.yMMMd().format(DateTime.now()),
            "${TimeOfDay.now().format(context)}-${TimeOfDay(hour: TimeOfDay.now().hour + 2, minute: TimeOfDay.now().minute).format(context)}",
          ),
          _getTimeLocation(
            Icons.location_on_outlined,
            "218 Eastern Avenue, IG4 5AB",
          ),
        ],
      ),
    );
  }

  Widget _getStatusItem(String title, Color color) {
    return DecoratedBox(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget _getTimeLocation(IconData icon, String title, [String? time]) {
    return Row(
      children: [
        Icon(icon, size: 15),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 10),
        time != null
            ? _getStatusItem(time, Colors.redAccent)
            : const SizedBox(),
      ],
    );
  }
}
