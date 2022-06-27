class Product {
  String? p_id;
  String? s_id;
  String? p_name;
  String? p_img;
  String? p_price;
  String? s_name;

  Product(
      {this.p_id,
      this.s_id,
      this.p_name,
      this.p_img,
      this.p_price,
      this.s_name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      s_id: json['s_id'] as String,
      p_id: json['p_id'],
      p_name: json['p_name'] as String,
      p_img: json['p_img'] as String,
      p_price: json['p_price'] as String,
      s_name: json['s_name'] as String,
    );
  }

  String get posterUrl => "http://hajin220.dothome.co.kr/img/${this.p_img}";
}
