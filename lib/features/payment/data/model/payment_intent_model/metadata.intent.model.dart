class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) {
    // نرجّع كائن فاضي بدل ما نرمي Exception
    return Metadata();
  }

  Map<String, dynamic> toJson() => {};
}
