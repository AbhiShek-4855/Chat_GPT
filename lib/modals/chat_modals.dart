class ChatModal{
  String message;
  bool isSent;
  String? dateTime;
  String? id;
  String? answer;

  ChatModal({required this.message,required this.isSent,this.dateTime,this.id,this.answer});


  factory ChatModal.fromJson(Map<String , dynamic> json) => ChatModal(
    message: json['message'],
    isSent: json['isSent'],
    dateTime: json['dateTime'],
    id: json['id'],
    answer: json['answer'],
  );


  Map<String ,dynamic > toJson() => {
    "message" : message,
    "dateTime" : dateTime,
    "isSent" : isSent,
    "id" : id,
    "answer" : answer,
  };

}
