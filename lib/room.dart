class Room{
  String? id;
  String? roomname;
  List<String>? appliances;
  
  Room({
    required this.id,
    required this.roomname,
    required this.appliances
  });

 Map<String,dynamic> toJson() =>{
    'id':id,
    'roomname':roomname,
    'appliances':appliances
 };
}