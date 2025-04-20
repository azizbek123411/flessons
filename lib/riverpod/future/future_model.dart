class FutureModel{
  final String name;
  final int id;

  FutureModel({
    required this.name,
    required this.id,
  });


  factory FutureModel.fromJson(Map<String,dynamic> json){
    return FutureModel(
      id: json['id'],
      name:json['name'],
    );
  }
}