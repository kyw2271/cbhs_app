class ServerInput {
  int count;
  Null next;
  Null previous;
  List<Menu> results;

  ServerInput({this.count, this.next, this.previous, this.results});

  ServerInput.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Menu>();
      json['results'].forEach((v) {
        results.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String days;
  String b;
  String l;
  String d;

  Menu({this.days, this.b, this.l, this.d});

  Menu.fromJson(Map<String, dynamic> json) {
    days = json['Days'];
    b = json['B'];
    l = json['L'];
    d = json['D'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Days'] = this.days;
    data['B'] = this.b;
    data['L'] = this.l;
    data['D'] = this.d;
    return data;
  }
}
