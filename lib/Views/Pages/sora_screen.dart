import 'package:flutter/material.dart';
import 'package:quran/Models/database.dart';
import 'package:quran/Views/Pages/ayat_screen.dart';

class SoraScreen extends StatefulWidget {
  const SoraScreen({Key? key}) : super(key: key);

  @override
  State<SoraScreen> createState() => _SoraScreenState();
}

class _SoraScreenState extends State<SoraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'السّور',
          style: TextStyle(
            fontFamily: 'quran',
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: QuranDB.retrive_sora(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var sora = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AyatScreen(sora_name:sora['name'],sora_id:sora['soraid']),
                      ),
                    );
                  },
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Card(
                      child: ListTile(
                        leading: sora['place'] == 1
                            ? Image.asset('assets/kaba.png')
                            : Image.asset('assets/medina.png'),
                        title: Text(
                          sora['name'],
                          style: const TextStyle(
                            fontFamily: 'quran',
                            fontSize: 23,
                          ),
                        ),
                        subtitle: Text(
                          sora['place'] == 1
                              ? 'مكية'
                              : 'مدنية',
                          style: const TextStyle(
                            fontFamily: 'quran',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
