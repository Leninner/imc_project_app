class ImcUserModel {
  final String imc;
  final double height;
  final double weight;
  final String createdAt;

  ImcUserModel({
    required this.imc,
    required this.height,
    required this.weight,
    required this.createdAt,
  });

  factory ImcUserModel.fromJson(Map<String, String> json) {
    return ImcUserModel(
      imc: json['imc'].toString(),
      height: double.parse(json['height'].toString()),
      weight: double.parse(json['weight'].toString()),
      createdAt: json['createdAt'].toString(),
    );
  }

  Map<String, String> toJson() {
    return {
      'imc': imc,
      'height': height.toString(),
      'weight': weight.toString(),
      'createdAt': createdAt,
    };
  }
}
