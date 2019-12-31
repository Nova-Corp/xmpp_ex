import 'package:flutter/material.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  String message;
  @override
  void initState() {
    super.initState();
    xmpp.Connection connection = xmpp.Connection(
        xmpp.XmppAccount("shan", "shan", "localhost.com", "1234", 5222));
    connection.open();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xmpp Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("XMPP Test"),
          leading: Icon(Icons.message),
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Row(
              children: <Widget>[
                Flexible(
                    child: TextFormField(
                  validator: (input) =>
                      input.length < 1 ? "Username can't be empty" : null,
                  onSaved: (input) => message = input,
                  decoration: InputDecoration(hintText: "Enter Message Here"),
                )),
                RaisedButton(
                  child: Icon(Icons.send),
                  onPressed: () => _submit(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print("Message is $message");
    }
  }
}
