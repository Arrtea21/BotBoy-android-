import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import 'botlogic.dart';

void main() {
  runApp(SplashScreen());
}

List userNames = ['User','theOutput'];

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white10,
        body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white10,
                backgroundImage: AssetImage('assets/images/gf.gif'),
              ),
              Text(
                'Hello There',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  'Welcome to this Useless App',
                  style: TextStyle(
                    color: Colors.lightGreenAccent,
                    fontSize: 20,

                  )
              ),
              SizedBox(
                height: 10,
                width: 150,
                child:
                Divider(
                  color: Colors.blueGrey,
                ),
              ),
              TextButton(
                onPressed: (){
                  runApp(DaBot());
                },
                child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    color: Colors.white,
                    child:Padding(
                        padding: EdgeInsets.all(0),
                        child: ListTile(
                          leading: Icon(
                            Icons.adb,
                            color: Colors.black87,
                          ),
                          title: Text(
                            'Continue ->',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        )
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DaBot extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DaBot',
      home: ChatScreen(),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController, this.num});
  var text;
  final AnimationController animationController;
  int num = 1;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController,curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                      userNames[num][0],
                    style: TextStyle(color: Colors.black),
                  )
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userNames[num], style: TextStyle(color: Colors.black)),
                    Container(
                      margin: EdgeInsets.only(top: 5.0,),
                      child: SelectableHtml(data: text,
                          onLinkTap: (url, RenderContext context, Map<String, String> attributes, element) async {
                            await launch(url);//open URL in webview, or launch URL in browser, or any other logic here
                          },
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];

  final _textController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  void _handleSubmit(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
      num: 0,
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
    zeroTwo(Text:text);
  }

  void zeroTwo({String Text}) async{
    print('called');
    ChatMessage message2 = ChatMessage(
      text:  await reply(userText:Text),
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
      num: 1,
    );
    setState(() {
      _messages.insert(0, message2);
    });
    print("yolo");
    message2.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Bot Boi'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor),
            child: _chatBody(),
          ),
        ],
      ),
    );
  }

  Widget _chatBody() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                decoration: InputDecoration.collapsed(
                    hintText: 'Send a message',),

                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _handleSubmit(_textController.text);
                    //zeroTwo();
                    }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}
