import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'botmodel.dart';

Future<String> reply({String userText})
async{
	String str = "work in progress";
	var url = Uri.parse('https://account.snatchbot.me/channels/api/api/id149287/app42069/aps420botboi69?user_id=AndroidApp');
	Map data = {
		"message": "$userText"
	};
	//encode Map to JSON
	var body = json.encode(data);
	var response = await http.post(url,headers: {"Accept": "application/json"},body: body,);
	if(response.statusCode == 200)
		{
			var jsonString = response.body;
			var jsonMap = BotModel.fromJson(json.decode(jsonString));
			print(jsonMap.messages[0].message);
			str = jsonMap.messages[0].message;
		}
	str = format(str);
	return str ;
}

String format(String response)
{
	int i=0, x=0;
	String str;
	List<String> tokens = <String>[];
	for(i=0;i<response.length;i++)
	{
		if(response[i]==' ')
		{
			tokens.add(response.substring(x,i));
			x=i+1;
		}
		if(i==response.length-1)
		{
			tokens.add(response.substring(x,i+1));
			x=i+1;
		}
	}
	for(i=0;i<tokens.length;i++)
		{
			if(i==0)
				str =tokens[i];
			else
				str +=' '+tokens[i];
		}
	print(tokens);
	return str;
}