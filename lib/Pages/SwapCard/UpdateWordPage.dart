import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../Model/Word.dart';
import '../../Service/Word_Service.dart';
import '../../provider/card_provider.dart';

class UpdateWord extends StatefulWidget {
   UpdateWord({super.key});


  @override
  State<UpdateWord> createState() => _UpdateWordState();
}

class _UpdateWordState extends State<UpdateWord> {
  Words receivedData = Get.arguments;
  String translated = '';
  String apiKey='';
  String text1="";
  int tut=0;
  String _mesaj="";
  TextEditingController firstTextFieldController = TextEditingController();
  TextEditingController firstTextFieldController2 = TextEditingController();

  wordservice wordser= wordservice();
  void sa(){
    if(tut==0) {
      firstTextFieldController.text = receivedData.firstWord!;
      firstTextFieldController2.text = receivedData.secondWord!;
      tut++;
    }
    else{
      firstTextFieldController.text=translated;
    }
  }
  void _submitForm() {
    receivedData.userId = 1;
    receivedData.firstWord  = translated;
    receivedData.secondWord  = text1;
    receivedData.languageId=1;
    receivedData.showCounter=0;
    receivedData.sentence="";
  }
  OverlayEntry? _overlayEntry;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardProvider>(context,listen: false);
    sa();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(onPressed: () { Get.back();}, icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('English', textAlign: TextAlign.center),

                TextFormField(
                  controller:firstTextFieldController2 ,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 10),
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (sa) async {
                    text1=sa;
                    const apiKey='AIzaSyDy0CmAlKCA5kYrQujDMGKblMSsZCrW9mE';
                    const to='tr';
                    final url=Uri.parse('https://translation.googleapis.com/language/translate/v2'
                        '?q=$sa&target=$to&key=$apiKey',
                    );
                    final  response = await http.post(url);

                    if (response.statusCode==200){
                      final body=json.decode(response.body);
                      final translations=body['data']['translations'] as List;
                      final translation = HtmlEscape().convert(
                        translations.first['translatedText'],
                      );

                      setState(() {
                        translated=translation;
                      });
                    }
                  },
                ),

                const SizedBox(height: 40), // Add some spacing between the text fields
                const Text('Turkish', textAlign: TextAlign.center),
                TextFormField(

                  controller: firstTextFieldController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 10),
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                    wordser.updateWord(receivedData);
                    Get.back();

                    _showOverlay();
                    setState(() {
                      _mesaj="Mesaj eklendi";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Kenar yuvarlama miktarını burada belirtin
                    ),

                    minimumSize: Size(200, 40),
                    elevation: 3,
                    primary: Colors.black, // Buton rengini siyah yapar
                  ),
                  child: FaIcon(FontAwesomeIcons.plusCircle),
                ),

              ],
            ),

          )),


    );

  }
  void _showOverlay() {
    // Container oluştur

    // Başarılı mesajı oluştur
    final successMessage = 'Başarılı oldu!';
    final overlayMessage = Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          successMessage,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          overlayMessage,
          SizedBox(height: 100,)
        ],
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);

    Timer(Duration(seconds: 2), () {
      _overlayEntry?.remove();
    });
  }

}
