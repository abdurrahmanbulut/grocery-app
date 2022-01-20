class Promotion {
  String id;
  String name;
  String desc;

  Promotion(this.id, this.name, this.desc);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc
    };
  }

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
      json["uid"],
      json["name"],
      json["desc"]
  );
}

Promotion createPromotion(record) {
  Map<String, dynamic> attributes = {
    'id': '',
    'name': '',
    'desc': ''
  };

  record.forEach((key, value) => {attributes[key] = value});

  Promotion promotion = Promotion(
      attributes['id'],
      attributes['name'],
      attributes['desc']);
  return promotion;
}