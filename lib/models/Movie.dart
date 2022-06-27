class Movie {
  String? s_id;
  String? s_name;
  String? s_img;
  String? s_min_price;
  String? s_tip;
  String? s_start;
  String? s_end;
  String? s_cnt;

  Movie(
      {this.s_id,
      this.s_name,
      this.s_img,
      this.s_min_price,
      this.s_tip,
      this.s_start,
      this.s_end,
      this.s_cnt});

  factory Movie.fromJson(Map<String, dynamic> json) {
    if (json['s_cnt'] == null) json['s_cnt'] = '0';

    return Movie(
      s_id: json['s_id'] as String,
      s_name: json['s_name'],
      s_img: json['s_img'] as String,
      s_min_price: json['s_min_price'] as String,
      s_tip: json['s_tip'] as String,
      s_start: json['s_start'] as String,
      s_end: json['s_end'] as String,
      s_cnt: json['s_cnt'] as String,
    );
  }

  String get posterUrl => "http://hajin220.dothome.co.kr/img/${this.s_img}";
}
