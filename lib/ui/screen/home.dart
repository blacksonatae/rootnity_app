import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/ui/widget/custom_popupmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<String> sectors = [
    "Home",
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

  String showNameSectors(String nameSectors) {
    return (nameSectors.length > 12) ? "${nameSectors.substring(0, 12)}..." : nameSectors;
  }

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
                            showNameSectors(sectors[index]),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          /*
          * Buatkan bentuk card
          * */
          SizedBox(height: 20),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(18.0),
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    'images/plant_design.png',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 100,
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Tidak Ada Perangkat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Themes.seasalt),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
