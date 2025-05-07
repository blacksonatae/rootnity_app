import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/core/model/Sector.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/ui/widgets/custom_popupmenu.dart';

//.. List Sektor
class ListSectors extends StatelessWidget {
  final List<Sector> sectors;
  final int sectorsCurrentIndex; //.. Sektor saat ini
  final ScrollController scrollController;
  final ValueChanged<int> onSectorsTap;

  const ListSectors({
    super.key,
    required this.sectors,
    required this.scrollController,
    required this.sectorsCurrentIndex,
    required this.onSectorsTap,
  });

  // Fungsi untuk mengurangi panjang nama sektor
  String _showNameSectors(String nameSectors) {
    return (nameSectors.length > 12)
        ? "${nameSectors.substring(0, 12)}..."
        : nameSectors;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              separatorBuilder: (context, snapshot) =>
                  const SizedBox(width: 25),
              itemCount: sectors.length,
              itemBuilder: (context, index) {
                bool isSelected = index == sectorsCurrentIndex;
                return GestureDetector(
                  onTap: () => onSectorsTap(index),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      _showNameSectors(sectors[index].nameSectors),
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected
                            ? RootColors.eerieBlack
                            : RootColors.seasalt,
                        fontWeight:
                            isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        CustomPopupMenu(
          menuItems: [
            PopupMenuItem(
              enabled: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                      maxWidth: 150,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          sectors.length,
                          (index) => PopupMenuItem(
                            child: Text(
                              _showNameSectors(sectors[index].nameSectors),
                            ),
                            onTap: () {
                              onSectorsTap(index);
                              print(
                                  "Sector dipilih : ${sectors[index].toJson()}");
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Kelola Sektor",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Icon(BootstrapIcons.table, size: 14),
                      ],
                    ),
                    onTap: () {

                    },
                  ),
                ],
              ),
            ),
          ],
          offset: const Offset(-145, 5),
          child: const Icon(
            BootstrapIcons.list,
            size: 24,
          ),
        ),
      ],
    );
  }
}
