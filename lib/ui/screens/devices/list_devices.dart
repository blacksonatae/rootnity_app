import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/core/models/device.dart';
import 'package:rootnity_app/core/theme/colors.dart';

class ListDevices extends StatelessWidget {
  final List<Device> devices;

  const ListDevices({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    //.. Jika tidak ada devices dalam sektor
    if (devices.isEmpty) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(18.0),
            width: double.infinity,
            child: Column(
              children: [
                Image.asset(
                  'images/plant_design.png',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 100,
                ),
                const SizedBox(height: 18),
                const Text(
                  "Tidak Ada Perangkat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: RootColors.seasalt,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
          childAspectRatio: 150 / 100),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return SizedBox(
          height: 100,
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: Row(
              children: [
                //.. Gambar perangkat
                Image.asset(
                  "images/devices.png",
                  fit: BoxFit.cover,
                ),
                //.. Informasi perangkat
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(BootstrapIcons.cpu,
                                size: 10, color: RootColors.brandeisBlue),
                            const SizedBox(width: 5),
                            Icon(BootstrapIcons.circle_fill,
                                size: 10, color: RootColors.kellyGreen),
                          ],
                        ),
                        const Spacer(),
                        //.. Nama perangkat
                        Flexible(
                          child: Text(
                            device.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}