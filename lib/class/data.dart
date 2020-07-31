class Album {
  final int status;
  final String message;
  final List<dynamic> data;

  Album({this.status, this.message, this.data});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        status: json['status'], message: json['id'], data: json['data']);
  }
}
