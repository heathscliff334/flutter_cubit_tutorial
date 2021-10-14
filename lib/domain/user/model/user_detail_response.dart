class UserDetailResponse {
  UserDetailResponse({
    required this.data,
    required this.support,
  });
  late final Data data;
  late final Support support;

  UserDetailResponse.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    support = Support.fromJson(json['support']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['support'] = support.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
  late final int id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String avatar;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['avatar'] = avatar;
    return _data;
  }
}

class Support {
  Support({
    required this.url,
    required this.text,
  });
  late final String url;
  late final String text;

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['text'] = text;
    return _data;
  }
}
