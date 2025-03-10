import 'package:flutter/material.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/services/auth_services.dart';
import 'package:rootnity_app/ui/screen/auth/login.dart';
import 'package:rootnity_app/ui/screen/home.dart';
import 'package:rootnity_app/ui/widget/custom_popupmenu.dart';
import 'package:rootnity_app/ui/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  String _userName =
      "Username"; //.. Variabel user name namun diinisialisasikan sebagai nilai default

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String fullName = preferences.getString('name') ?? "User";

    setState(() {
      _userName =
          (fullName.length > 12) ? "${fullName.substring(0, 12)}..." : fullName;
    });
  }

  void _logout() async {
    AuthServices
        .logout(); //.. Memanggil fungsi untuk menghapus data saat logout
    //.. Kembali kehalaman login
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    //.. Menampilkan pesan jika logout sudah berhasil dengan toast
    CustomToast.show(context, "Berhasil Logout !", "info");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          _buildHeader(), //.. Fungsi Header
          Expanded(child: const HomeScreen()),
        ],
      )),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //.. Nama User atau User Name
              Text(
                _userName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Themes.eerieBlack,
                ),
              ),
              /*
              * Menambahkan masing" button dengan CustomPopUpMenu,
              * saat ditekan maka muncul menu berupa popup
              * */
              //.. Menu untuk logout
              CustomPopupmenu(
                menuItems: [
                  PopupMenuItem(
                    child: Text("Logout"),
                    onTap: () => _logout(),
                  )
                ],
                offset: Offset(-60, 30),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
            ],
          ),
          CustomPopupmenu(
            menuItems: [
              PopupMenuItem(child: Text("Tambah Sektor"), onTap: () {

              }),
              PopupMenuItem(child: Text("Tambah Perangkat"), onTap: () {

              }),
            ],
            offset: Offset(-150, 30),
            child: Icon(
              Icons.add_circle_outline,
              color: Themes.eerieBlack,
            ),
          ),
        ],
      ),
    );
  }
}
