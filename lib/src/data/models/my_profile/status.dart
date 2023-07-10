class Status {
  int? code;
  String? message;

  Status({
    this.code,
    this.message,
  });

  Status copyWith({
    int? code,
    String? message,
  }) =>
      Status(
        code: code ?? this.code,
        message: message ?? this.message,
      );

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
