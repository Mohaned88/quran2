import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quran/Models/database.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:extended_text_library/extended_text_library.dart';

class AyatScreen extends StatelessWidget {
  String sora_name;
  int sora_id;

  AyatScreen({Key? key, required this.sora_name, required this.sora_id})
      : super(key: key);

  Directionality appDirectionality({required Widget child}) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Builder(
        builder: (BuildContext context) {
          return new MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sora_name,
          style: const TextStyle(
            fontFamily: 'quran',
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/quran_frame2.png',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
            child: FutureBuilder(
              future: QuranDB.retrive_ayat(sora_id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: sora_id == 1
                                ? compine_ayat2(snapshot.data!)
                                : [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![0]['text'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          runAlignment: WrapAlignment.center,
                                          children:
                                              compine_ayat3(snapshot.data!),
                                        ),
                                      ],
                                    ),
                                  ],
                          ),
                        ),
                      ),
                      /*RichText(
                        textAlign: TextAlign.center,
                        text: sora_id == 1
                            ? TextSpan(
                                text: '',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 22),
                                children: List.generate(
                                  snapshot.data!.length,
                                  (index) => TextSpan(
                                    text: '${snapshot.data![index]['text']}',
                                    children: [
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/AyaNumber.png',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                Text(
                                                  '${ArabicNumbers().convert(1234)}',
                                                  //'${ArabicNumbers().convert(snapshot.data![index]['ayaid'])}',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontFamily: 'quran',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        alignment: PlaceholderAlignment.middle,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : TextSpan(
                                text: '${snapshot.data![0]['text']}\n',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                children: List.generate(
                                  snapshot.data!.length - 1,
                                  (index) => TextSpan(
                                    text:
                                        ' ${snapshot.data![index + 1]['text']}',
                                    children: [
                                      WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 14,
                                              backgroundImage: AssetImage(
                                                'assets/AyaNumber.png',
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Text(
                                                ' ${ArabicNumbers().convert(snapshot.data![index + 1]['ayaid'])} ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          alignment:
                                              PlaceholderAlignment.middle),
                                    ],
                                  ),
                                ),
                              ),
                        */
                      /*TextSpan(
                          text: '',
                          children: compine_ayat(snapshot.data!),
                        ),*/
                      /*
                      ),*/
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> compine_ayat3(List sora) {
    List<Widget> myList = [];
    //if (sora[0]['ayaid'] == 1) {
    var x = sora.getRange(1, sora.length);
    for (var aya in x) {
      int ids = aya['ayaid'];
      String ayat = aya['text'] as String;
      List l2 = ayat.split(' ');
      myList.addAll(List.generate(l2.length, (index) {
        return RichText(
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '${l2[index]} ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        );
      }));
      myList.add(
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/AyaNumber.png',
              width: 30,
              height: 30,
            ),
            Text(
              '${ArabicNumbers().convert(ids)}',
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      );
    }
    // }
    /*else {
      myList.add(
        Text(
          '${sora[0]['text']}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      );
      for (var aya in sora.getRange(1, sora.length - 1)) {
        int ids = aya['ayaid'];
        String ayat = aya['text'] as String;
        List l2 = ayat.split(' ');
        myList.addAll(List.generate(l2.length, (index) {
          return RichText(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap = (){
                print('${l2[index]} ');
              },
              text: '${l2[index]} ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          );
        }));
        myList.add(
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/AyaNumber.png',
                width: 30,
                height: 30,
              ),
              Text(
                '${ArabicNumbers().convert(ids)}',
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        );
      }
    }*/
    return myList;
  }

  List<Widget> compine_ayat2(List sora) {
    List<Widget> myList = [];
    //if (sora[0]['ayaid'] == 1) {
    for (var aya in sora) {
      int ids = aya['ayaid'];
      String ayat = aya['text'] as String;
      List l2 = ayat.split(' ');
      myList.addAll(List.generate(l2.length, (index) {
        return RichText(
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '${l2[index]} ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        );
      }));
      myList.add(
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/AyaNumber.png',
              width: 30,
              height: 30,
            ),
            Text(
              '${ArabicNumbers().convert(ids)}',
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      );
    }
    // }
    /*else {
      myList.add(
        Text(
          '${sora[0]['text']}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      );
      for (var aya in sora.getRange(1, sora.length - 1)) {
        int ids = aya['ayaid'];
        String ayat = aya['text'] as String;
        List l2 = ayat.split(' ');
        myList.addAll(List.generate(l2.length, (index) {
          return RichText(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap = (){
                print('${l2[index]} ');
              },
              text: '${l2[index]} ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          );
        }));
        myList.add(
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/AyaNumber.png',
                width: 30,
                height: 30,
              ),
              Text(
                '${ArabicNumbers().convert(ids)}',
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        );
      }
    }*/
    return myList;
  }

  compine_ayat(ayat) {
    List<WidgetSpan> widgets = [];
    for (Map aya in ayat) {
      widgets.add(
        WidgetSpan(
          child: Text(
            '${aya['text']} ',
          ),
        ),
      );
      widgets.add(
        WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  'assets/AyaNumber.png',
                ),
                backgroundColor: Colors.transparent,
                child: Text(
                  ' ${ArabicNumbers().convert(aya['ayaid'])} ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            alignment: PlaceholderAlignment.middle),
      );
    }
    return widgets;
  }
}
