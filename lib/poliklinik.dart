import 'package:antrian_rs/daftar.dart';
import 'package:antrian_rs/pasienbaru.dart';
import 'package:antrian_rs/pasienlama.dart';
import 'package:flutter/material.dart';
import './homepage.dart';

class Poliklinik extends StatefulWidget {
  static bool before = true;
  const Poliklinik({Key? key}) : super(key: key);

  @override
  _PoliklinikState createState() => _PoliklinikState();
}

class _PoliklinikState extends State<Poliklinik> {
  void kembali() {
    if (Poliklinik.before) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PasienLama()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PasienBaru()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff406882),
        shadowColor: const Color(0xff406882),
        elevation: 0,
        title: const Text("Langkah 3/4"),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: kembali),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xff406882),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "PILIH POLIKLINIK",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: const Text(
                  "Silahkan memilih poliklinik yang tersedia",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.73,
                alignment: Alignment.centerLeft,
                child: const ListPoli(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ListPoli extends StatefulWidget {
  const ListPoli({Key? key}) : super(key: key);

  @override
  _ListPoliState createState() => _ListPoliState();
}

class _ListPoliState extends State<ListPoli> {
  List listPoli = [
    {"id": "A", "nama": "Poli Umum"},
    {"id": "B", "nama": "Poli Kardoiologi"},
    {"id": "C", "nama": "Poli Anak"},
    {"id": "D", "nama": "Poli THT"},
    {"id": "E", "nama": "Poli Kulit & Kelamin"},
    {"id": "F", "nama": "Poli Gizi"},
    {"id": "G", "nama": "Poli Radioterapi"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listPoli.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, right: 30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0)))),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      listPoli[index]['nama'],
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffB8B6B6),
                      size: 30,
                    )
                  ],
                ),
                onPressed: () {
                  Daftar.id = listPoli[index]['id'];
                  Daftar.poli = listPoli[index]['nama'];
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Daftar()),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
          );
        });
  }
}
