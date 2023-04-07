import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import 'providers/text_provider.dart';

class TextWindow extends StatefulWidget {
  const TextWindow({super.key});

  @override
  State<TextWindow> createState() => _TextWindowState();

  void function(String char) {
    debugPrint('function() called for $char');
  }
}

class _TextWindowState extends State<TextWindow> 
{

  // Text Controller
  final TextEditingController _controller = TextEditingController();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = context.read<TextProvider>().text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[600],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(12.0),
                child:
                    // RichText(
                    //   textAlign: TextAlign.right,
                    //   text: const TextSpan(
                    //     text: 'मि',
                    //     style: TextStyle(
                    //       fontSize: 28.0,
                    //       fontFamily: 'Bharati',
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),

//                       Html(
//                     data: """
//                     <style type="text/css">
// .generated-text {
//    font-family:Copperplate;
//    font-size:16px;
//    line-height:20px;
//    color:#000000;
//    background-color:#ffffff;
//    padding:20px;
// }
// </style>
// <!-- HTML Code -->
// <p class="generated-text">मि</p>
//                   """,
//                   )

                    Text(
                  context.watch<TextProvider>().text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFeatures: [FontFeature.enable('smcp')],
                    fontSize: 28.0,
                    fontFamily: 'Bharati',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  context.watch<TextProvider>().text,
                  //'भारति',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
