class Validators {
  //.. Mengubah huruf teks jadi kapital
  String capitalize(String? text) {
    return text[0].toUpperCase().substring(1).toLowerCase();
  }
}
