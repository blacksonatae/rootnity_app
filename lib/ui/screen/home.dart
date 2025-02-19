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
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: sectors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("${sectors[index]} is clicked");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      sectors[index],
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            child: Text("Center"),
          )
        ],
      ),
    );
  }
}
