// ignore_for_file: unused_import, avoid_print

import 'dart:convert';

import 'package:antrian_rs/daftar.dart';

import './poliklinik.dart';
import 'package:antrian_rs/tiket.dart';
import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:http/http.dart' as http;

class Cari extends StatefulWidget {
  const Cari({Key? key}) : super(key: key);

  @override
  _CariState createState() => _CariState();
}

class _CariState extends State<Cari> {
  TextEditingController rm = TextEditingController();

  void lanjut() async {
    // print(rm.text);
    try {
      final res = await http.post(Uri.parse("http://10.0.2.2/rs/cari.php"),
          body: {"rm": rm.text});
      ;
      List ll = jsonDecode(res.body);
      String nama = ll[0]['nama'];

      final hasil = await http.post(
          Uri.parse("http://10.0.2.2/rs/caritiket.php"),
          body: {"rm": rm.text});
      List list = jsonDecode(hasil.body);
      setState(() {
        DetailTiket.hp = list[0]['hp'];
        DetailTiket.jenis = list[0]['jenis'];
        Pasien.nama = nama;
        DetailTiket.no = list[0]['nomor'];
        DetailTiket.tanggal = list[0]['tanggal'];
        DetailTiket.poli = list[0]['poli'];
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Tiket()),
          (Route<dynamic> route) => false);
    } catch (err) {
      print(err);
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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false),
        ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Cari Tiket",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: const Text(
                  "Masukkan nomor RM anda agar kami dapat mencari tiket anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Nomor RM",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                            controller: rm,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 12)),
                            ))),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffE4CDA7),
                            side: const BorderSide(
                                width: 1, color: Colors.black)),
                        onPressed: () => lanjut(),
                        // Navigator.of(context)
                        //     .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Tiket()), (Route<dynamic> route) => false),
                        child: const Text(
                          "SELANJUTNYA",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          )
        ],
      ),
    );
  }
}
