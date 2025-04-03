class TodoRiverModel{
  final String id;
  final String title;
  final bool isCompleted;
  TodoRiverModel({
    required this.id,
    required this.title,
    this.isCompleted=false,
  });

TodoRiverModel copyWith({String? title, bool? isCompleted}){
  return TodoRiverModel(
    id: id,
    title: title??this.title,
    isCompleted: isCompleted??this.isCompleted,
  );
}


}