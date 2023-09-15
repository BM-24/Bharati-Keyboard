import 'dart:io';

import 'package:bharati_keyboard/providers/languages.dart';
import 'package:bharati_keyboard/providers/text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:showcaseview/showcaseview.dart';
import 'package:app_tutorial/app_tutorial.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolBar extends StatefulWidget {
  ToolBar(
      {super.key,
      required this.language,
      required this.currentLang,
      required this.screenshotController});

  int language;
  String currentLang;
  List<String> languageList = Languages.languageList;
  List<String> languageNames = Languages.languageNames;
  final ScreenshotController screenshotController;
  // int mode = 0;

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  String bharatiLanguage = "";
  String currentLanguage = "";
  int mode = 0;

  final GlobalKey _share = GlobalKey();
  final GlobalKey _mode = GlobalKey();
  final GlobalKey _language = GlobalKey();
  List<TutorialItem> items = [];

  @override
  void initState() {
    super.initState();
    bharatiLanguage = 'भारति';
    currentLanguage = widget.currentLang;
    initItems();
    // Future.delayed(const Duration(microseconds: 200)).then((value) {
    //   Tutorial.showTutorial(context, items, onTutorialComplete: () {
    //     // Code to be executed after the tutorial ends
    //     print('Tutorial is complete!');
    //   });
    // });
    // Intro.of(context).start();
    // mode = widget.mode;
  }

  void initItems() {
    items.addAll({
      TutorialItem(
        globalKey: _share,
        color: Colors.black.withOpacity(0.6),
        borderRadius: const Radius.circular(15.0),
        shapeFocus: ShapeFocus.roundedSquare,
        child: const TutorialItemContent(
          title: 'Share button',
          content: 'Click here to share the text.',
        ),
      ),
      TutorialItem(
        globalKey: _mode,
        shapeFocus: ShapeFocus.square,
        borderRadius: const Radius.circular(15.0),
        child: const TutorialItemContent(
          title: 'Change mode',
          content: 'Click here to change the mode.',
        ),
      ),
      TutorialItem(
        globalKey: _language,
        color: Colors.black.withOpacity(0.6),
        shapeFocus: ShapeFocus.oval,
        child: const TutorialItemContent(
          title: 'Choose Language',
          content: 'Click here to change the language.',
        ),
      ),
    });
  }

  void captureAndShareScreenshot() async {
    Uint8List? uint8list = await widget.screenshotController.capture();

    // final directory = await getApplicationDocumentsDirectory();
    final tempDirectory = await getTemporaryDirectory();
    final imagePath = await File('${tempDirectory.path}/image.png').create();
    final file = await imagePath.writeAsBytes(uint8list!);

    if (file.existsSync()) {
      debugPrint("File exists");
      await Share.shareXFiles([XFile('${tempDirectory.path}/image.png')]);
      Navigator.of(context).pop();
    } else {
      debugPrint("File does not exist");
      // show a popup message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Error in sharing"),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    // dismiss

    // Request Storage permission
    // if (await Permission.storage.request().isGranted) {
    //   // Save image to gallery
    //   final result = await ImageGallerySaver.saveImage(uint8list!);
    //   debugPrint(result.toString());

    //   if (result != null && result['isSuccess'] == true) {
    //     // Get the saved image path
    //     final savedImagePath = result['filePath'] as String;

    //     // create xfile object from the saved path
    //     debugPrint(savedImagePath);
    //     // final xFile = XFile(savedImagePath);
    //     debugPrint(result['filePath'] + ".jpg");

    //     // final shared_result = await Share.shareXFiles([
    //     //   XFile(result['filePath'] + ".jpg"),
    //     // ]);
    //     // debugPrint(shared_result.toString());

    //     await Share.shareXFiles([XFile("$savedImagePath.jpg")]);

    //     // Share the saved image
    //     // Share.shareXFiles([savedImagePath]);

    //     // Share the image using share plus
    //   }
    // }
  }

  void shareText() async {
    // String text = context.read<TextProvider>().text;
    String text = context
        .read<Languages>()
        .getMappedText(context.read<TextProvider>().text);
    await Share.share(text);
    Navigator.of(context).pop();
  }

  void showSharePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text("Share"),
          content: const Text("How do you want to share?"),
          actions: [
            TextButton(onPressed: shareText, child: const Text("Text")),
            TextButton(
                onPressed: captureAndShareScreenshot,
                child: const Text("Image")),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 4.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.orange[300],
        //borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            key: _share,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              if (context.read<TextProvider>().text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("There is no text to share."),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              showSharePopup(context);
            },
            icon: const Icon(Icons.share),
          ),
          // IntroStepBuilder(
          //   order: 1,
          //   text: 'Click here to share the text.',
          //   builder: ((context, key) {
          //     return IconButton(
          //       key: key,
          //       splashColor: Colors.transparent,
          //       highlightColor: Colors.transparent,
          //       onPressed: () {
          //         showSharePopup(context);
          //       },
          //       icon: const Icon(Icons.share),
          //     );
          //   }),
          // ),
          // Showcase(
          //   key: _share,
          //   description: 'Click here to share the text',
          //   child: IconButton(
          //     splashColor: Colors.transparent,
          //     highlightColor: Colors.transparent,
          //     onPressed: () {
          //       showSharePopup(context);
          //     },
          //     icon: const Icon(Icons.share),
          //   ),
          // ),
          Text(
            bharatiLanguage,
            style: mode == 0
                ? const TextStyle(
                    fontFamily: 'NavBharati',
                    fontSize: 20,
                  )
                : const TextStyle(
                    fontSize: 20,
                  ),
          ),
          IconButton(
            key: _mode,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                mode = (mode + 1) % 2;
                context.read<Languages>().setMode(mode);

                String temp = bharatiLanguage;
                bharatiLanguage = currentLanguage;
                currentLanguage = temp;
              });
            },
            icon: const Icon(Icons.compare_arrows_rounded),
          ),
          Text(
            currentLanguage,
            // widget.languageNames[widget.language],
            style: mode == 1
                ? const TextStyle(
                    fontFamily: 'NavBharati',
                    fontSize: 20,
                  )
                : const TextStyle(
                    fontSize: 20,
                  ),
          ),
          // Drop down menu
          // IntroStepBuilder(
          //     order: 2,
          //     text: 'Click here to change the language.',
          //     builder: ((context, key) {
          //       return DropdownButton<String>(
          //         key: key,
          //         value: widget.languageList[widget.language],
          //         iconSize: 24,
          //         elevation: 16,
          //         style: const TextStyle(color: Colors.black),
          //         alignment: Alignment.center,
          //         underline: Container(
          //           height: 2,
          //           color: Colors.grey,
          //         ),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             widget.language = widget.languageList.indexOf(newValue!);
          //             context
          //                 .read<Languages>()
          //                 .setChoosenLanguageIndex(widget.language);

          //             if (mode == 1) {
          //               bharatiLanguage = widget.languageNames[widget.language];
          //             } else {
          //               currentLanguage = widget.languageNames[widget.language];
          //               widget.currentLang = currentLanguage;
          //             }

          //             // debugPrint(currentLanguage);
          //             // debugPrint(bharatiLanguage);
          //             // debugPrint("mode : $mode");

          //             context.read<TextProvider>().setText("");

          //             debugPrint("Mode : ${context.read<Languages>().mode}");
          //           });
          //         },
          //         items: widget.languageList
          //             .map<DropdownMenuItem<String>>((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(
          //               value,
          //               textAlign: TextAlign.center,
          //               style: const TextStyle(fontSize: 20),
          //             ),
          //           );
          //         }).toList(),
          //       );
          //     })),
          DropdownButton<String>(
            key: _language,
            value: widget.languageList[widget.language],
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            alignment: Alignment.center,
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.language = widget.languageList.indexOf(newValue!);
                context
                    .read<Languages>()
                    .setChoosenLanguageIndex(widget.language);

                if (mode == 1) {
                  bharatiLanguage = widget.languageNames[widget.language];
                } else {
                  currentLanguage = widget.languageNames[widget.language];
                  widget.currentLang = currentLanguage;
                }

                // debugPrint(currentLanguage);
                // debugPrint(bharatiLanguage);
                // debugPrint("mode : $mode");

                context.read<TextProvider>().setText("");

                debugPrint("Mode : ${context.read<Languages>().mode}");
              });
            },
            items: widget.languageList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
          ),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              // Vibrate.feedback(FeedbackType.medium);
              Future.delayed(const Duration(microseconds: 200)).then((value) {
                Tutorial.showTutorial(context, items, onTutorialComplete: () {
                  // Code to be executed after the tutorial ends
                  print('Tutorial is complete!');
                });
              });
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
    );
  }
}

class TutorialItemContent extends StatelessWidget {
  const TutorialItemContent({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  void _launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () => Tutorial.skipAll(context),
                        child: const Text(
                          'Skip Tutorial',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  const Spacer(),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TextButton(
                      onPressed: null,
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                // Buttton with Icon
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // show popup
                      Tutorial.skipAll(context);

                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text("Bharati Script"),
                              content: const Text(
                                  "Bharati is a simple and unifled script which can be used to write most major Indian languages.\n• It is designed by identifying the simplest glyphs and by borrowing characters from various Indian scripts often to make it look familiar\n• Bharati characters are designed such that the phonetics of the character is reflected in its shape, and will therefore be easy to remember. \n•Scripts currently supported are: Devanagari (Hindi, Marathi,etc.), Bengali,    Gujarati,    Gurmukhi,    Kannada, Malayalam, Odia, Tamil, and Telugu.\n• This script is developed by Prof. V. Srinivasa Chakravarthy, Indian Institute of Technology - Madras.\n"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      _launchURL(
                                          'https://youtu.be/YHFHUAPrCWM');
                                    },
                                    child: const Text("LEARN BHARATI")),
                                TextButton(
                                    onPressed: () {
                                      _launchURL('https://bharatiscript.com');
                                    },
                                    child: const Text("GO TO WEBSITE")),
                              ],
                            );
                          }));
                    },
                    child: const Text(
                      'App Info',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
