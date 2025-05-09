class Validators {
  //.. Mengubah huruf teks jadi kapital
  static String capatilize(String text) {
    if(text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
