class PostModel{
  final int id;
final String title;
final String body;
PostModel({
  required this.id,
  required this.title,
  required this.body,
});

factory PostModel.fromJson(Map<String,dynamic>json){
  return PostModel(
    id: json['id'],
    title: json['title'],
    body:json['body'],
  );
}

Map<String,dynamic> toJson(){
  return{
    'id':id,
    'title':title,
    'body':body 
     };
}

PostModel copyWith({String? title,String? body,int? id,}){
  return PostModel(
    id:id??this.id,
    body: body??this.body,
    title: title??this.title,
  );
}
}