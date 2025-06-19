class Result<T> {
  final int status;
  final T? data;
  final String message;

  Result({
    required this.status,
    required this.data,
    required this.message,
  });

  factory Result.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return Result(
      status: json['status'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      message: json['message'] ?? json['meessage'] ?? '',
    );
  }
}
