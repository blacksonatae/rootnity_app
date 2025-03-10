import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/services/sectors_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  int _sectorCurrentIndex = 0; //.. Indeks pada sektor

  //.. Gunakan iniState agar data atau konten diload saat halama dibuka
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchSectors();
  }

  List<String> sectors = [];

  void _fetchSectors() async {
    List<dynamic> sectorList = await SectorServices.getSectors();
    setState(() {
      sectors = sectorList.map((sector) => sector['name_sectors'].toString()).toList();
    });
    print(sectorList);
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
