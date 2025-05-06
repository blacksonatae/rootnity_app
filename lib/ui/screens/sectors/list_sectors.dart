import 'package:flutter/material.dart';
import 'package:rootnity_app/core/model/Sector.dart';

//.. List Sektor
class ListSectors extends StatelessWidget {
  final List<Sector> sectors;
  final int sectorsId;
  final ScrollController scrollController;

  const ListSectors({
    super.key,
    required this.sectors, required this.scrollController, required this.sectorsId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: SizedBox(
          height: ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount),
        ))
      ],
    );
  }
}
