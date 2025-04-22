class FutureModel{
  final String title;
  final int id;
  final String body;
  FutureModel({
    required this.title,
    required this.id,
    required this.body
  });


  factory FutureModel.fromJson(Map<String,dynamic> json){
    return FutureModel(
      id: json['id'],
      title:json['title'],
      body:json['body']
    );
  }


  Map<String,dynamic> toJson(){
    return {
      'title':title,
      'body':body,
    };
  }


  FutureModel copyWith({String? title,String? body,int? id}){
    return FutureModel(
      title: title??this.title, id: id??this.id, body: body??this.body);
  }
}