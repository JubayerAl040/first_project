import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        toolbarHeight: size.height * .19,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_outlined, color: Colors.white),
                  ),
                  const Spacer(),
                  const CircleAvatar(radius: 30, backgroundColor: Colors.white),
                  const Spacer(),
                  const Icon(Icons.star_border_outlined, color: Colors.grey),
                  const Icon(Icons.upload_outlined, color: Colors.grey)
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Ling's Laundry & Store",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 5),
              const Text(
                "Laundry Care",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star,
                    color: i == 4 ? Colors.white : Colors.yellow,
                    size: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // booking-help container
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[850],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.help_outline_rounded, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Booking Help",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          size: 14, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // booking-details card
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400]!,
                      spreadRadius: 1,
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    ),
                    const BoxShadow(
                        color: Colors.white, spreadRadius: 1, blurRadius: 30),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.edit_document, size: 35),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Booking Details",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "#DA123456",
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                      const Text(
                        "Booking made on 13 January 2024",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      _getTimeLocation(
                        Icons.calendar_month,
                        DateFormat.yMMMd().format(DateTime.now()),
                        "${TimeOfDay.now().format(context)}-${TimeOfDay(hour: TimeOfDay.now().hour + 2, minute: TimeOfDay.now().minute).format(context)}",
                      ),
                      const SizedBox(height: 5),
                      _getTimeLocation(
                        Icons.location_on_outlined,
                        "218 Eastern Avenue, IG4 5AB",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // serice-details container
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400]!,
                      spreadRadius: 1,
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    ),
                    const BoxShadow(
                        color: Colors.white, spreadRadius: 1, blurRadius: 30),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.shopping_bag_sharp, size: 35),
                          SizedBox(width: 10),
                          Text(
                            "Service Details",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _getServiceDetailsItem(
                        "2 Bags (5kg each) Wash, Dry & Fold",
                        "\$40",
                        12,
                        Colors.black,
                      ),
                      const Divider(),
                      _getServiceDetailsItem(
                          "Platform Fee", "\$1.99", 12, Colors.grey),
                      _getServiceDetailsItem(
                          "Service Fee", "\$1.50", 12, Colors.grey),
                      const Divider(),
                      _getServiceDetailsItem(
                          "Total Fee", "\$43.49", 14, Colors.black),
                      _getServiceDetailsItem(
                        "Total Paid with Visa ending in 8412",
                        "\$43.49",
                        12,
                        Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getServiceDetailsItem(
      String title, String money, double fontSize, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: fontSize, color: color),
        ),
        Text(money,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: fontSize, color: color)),
      ],
    );
  }

  Widget _getTimeLocation(IconData icon, String title, [String? time]) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 10),
        Text(title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(width: 10),
        time != null
            ? _getStatusItem(time, Colors.redAccent)
            : const SizedBox(),
      ],
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
}
