
import 'package:fp/models/classModels.dart';
import 'package:fp/screens/chatbotScreen/chat_model.dart';
import 'package:fp/screens/massageScreen/chatModel.dart';

String ?tokenPassword;
List? categories=['تجاري و شركات','عمال','مجلس الدولة'];
String ?userTp;
bool done=true;
LoginModel ?loginmodel;
String ?token;
ChatClientModel?chatModel;
ChatData?chatData;
List chat=[];
List chatWho=[];
Map ?lawyerForUser;
Map ?clientForLawyer;
Map user={};