class Order {
  String? o_id;
  String? o_list;
  String? o_location;
  String? o_total;
  String? o_phone_number;
  String? o_status;
  String? s_name;
  String? s_img;

  Order(
      {this.o_id,
      this.o_list,
      this.o_location,
      this.o_total,
      this.o_phone_number,
      this.o_status,
      this.s_name,
      this.s_img});

  factory Order.fromJson(Map<String, dynamic> json) {
    var tmp = json['o_list'] as String;
    var s_tmp = "";

    List<String> p = tmp.trim().split(';');

    for (int i = 0; i < p.length - 1; i++) {
      var q = p[i].split(':');

      s_tmp += (q[0] + " " + q[1] + "개\n");
    }
    return Order(
      o_id: json['o_id'] as String,
      //o_list: json['o_list'],
      o_list: s_tmp,
      o_location: json['o_location'] as String,
      o_total: json['o_total'] as String,
      o_phone_number: json['o_phone_number'] as String,
      o_status: json['o_status'] as String,
      s_name: json['s_name'] as String,
      s_img: json['s_img'] as String,
      //s_name: json['s_name'] as String,
    );
  }

  String get posterUrl => "http://hajin220.dothome.co.kr/img/${this.s_img}";
}
