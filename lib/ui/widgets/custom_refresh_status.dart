import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefreshStatus extends StatelessWidget {
  // final String dirAnimation;
  // final String textRefreshStatus;

  const CustomRefreshStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(builder: (context, mode) {
      String? dirAnimation;
      String textRefreshStatus;

      //.. Kondisi mode refresh dapat gunakan switch case
      switch (mode) {
        case RefreshStatus.canRefresh:
          textRefreshStatus = "Lepaskan untuk memuat...";
          dirAnimation = "assets/animations/hover_arrow_down.gif";
          break;
        case RefreshStatus.refreshing: //.. Melakukan refresh halaman
          textRefreshStatus = "Memuat...";
          dirAnimation = "assets/animations/loading_animation.gif";
          break;
        case RefreshStatus.completed: //.. Jika berhasil refresh
          textRefreshStatus = "Sukses";
          dirAnimation = "assets/animations/checklist_animation.gif";
          break;
        case RefreshStatus.failed:
          textRefreshStatus = "Gagal! Terjadi kesalahan...";
          dirAnimation = "assets/animations/errors_animation.gif";
          break;
        default:
          textRefreshStatus = "Tarik kebawah untuk refresh";
          break;
      }

      return Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //.. Icons dalam bentuk animasi
                if (dirAnimation != null)
                  SizedBox(
                    height: 30,
                    child: Image.asset(
                      dirAnimation,
                      fit: BoxFit.contain,
                    ),
                  ),
                SizedBox(height: 5),
                //.. Text
                Text(
                  textRefreshStatus,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
