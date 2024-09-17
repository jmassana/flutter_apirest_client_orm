class ResponseResult<T> {
  bool success;
  T? data;
  String? message;

  ResponseResult({required this.success, this.data, this.message});

  factory ResponseResult.fromJson(Map<String, dynamic> json) {
    return ResponseResult(
      success: json["success"],
      data: json["data"],
      message: json["message"],
    );
  }
}
