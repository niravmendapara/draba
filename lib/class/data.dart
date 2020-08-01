class Album {
  final int status;
  final String message;
  final List<dynamic> data;

  Album({this.status, this.message, this.data});

  factory Album.fromJson(Map<String, dynamic> json) {
    if(json['data'] is List){
      return Album(
          status: json['status'], message: json['id'], data: json['data']);
    }
    else{
      return Album(
          status: json['status'], message: json['id'], data: json['data']['data']);
    }
  }
}

var urlSet = [
  'http://167.172.149.230/api/get-hot-events?page=1&limit=10&%20user_id=6',
  'http://167.172.149.230/api/get-new-events?page=1&limit=10&%20user_id=6',
  'http://167.172.149.230/api/get-events?page=1&limit=10&%20user_id=6',
  'http://167.172.149.230/api/get-special-events?page=1&limit=10&%20user_id=6'
];