class Tip {
  Tip();

  factory Tip.fromJson(Map<String, dynamic> json) {
    // نرجع كائن فاضي بدل ما نرمي Exception
    return Tip();
  }

  Map<String, dynamic> toJson() => {};
}
