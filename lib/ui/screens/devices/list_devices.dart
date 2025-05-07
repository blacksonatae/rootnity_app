import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/core/model/Device.dart';
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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 5,
        childAspectRatio: 1,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  BootstrapIcons.device_hdd,
                  size: 30,
                  color: RootColors.eerieBlack,
                ),
                const SizedBox(height: 8),
                Text(
                  device.nameDevices,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
