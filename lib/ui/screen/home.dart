import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<String> sectors = [
    "Tora Farms",
    "Hans",
    "Halaman Belakang",
    "Kevin Farms",
    "Kedamaian Permai",
    "Mayor Ruslan",
    "Kazana",
    "Farm Smasf",
    "John Farms",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // List Sectors
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount: sectors.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 25,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            print("${sectors[index]} is Clicked");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              sectors[index],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.view_list_rounded),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text("Devices"),
            ),
          ),
        ],
      ),
    );
  }
}
