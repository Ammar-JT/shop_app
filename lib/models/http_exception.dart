class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    //ببساطة الكلاس بكبرو بس ياخد النص ويرجعه تاني، لكن يرجع على شكل اكسبشن !
    //فتقدر تسوي ثروو اكسبشن وتحط النص اللي تبغاه باستخدام دا الكلاس
    return message;
    // return super.toString(); //<<<instance of HttpException
  }
}
