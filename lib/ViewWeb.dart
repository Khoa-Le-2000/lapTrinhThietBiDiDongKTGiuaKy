import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewPage extends StatefulWidget {
  final String url;
  const ViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue,size: 20,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "KL NEWS",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Expanded(
              child: WebView(
                initialUrl: widget.url,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
