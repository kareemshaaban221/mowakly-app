class ChatClientModel{
  ChatData ?data;
  ChatClientModel.fromJson(Map json){
    data=ChatData.fromJson(json['data']);
  }
}

class ChatData{
  List ?data;


  ChatData.fromJson(Map json){
    data=json['data'];

  }

}