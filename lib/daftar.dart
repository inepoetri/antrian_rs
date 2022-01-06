// ignore_for_file: unused_local_variable, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:antrian_rs/poliklinik.dart';
import 'package:antrian_rs/tiket.dart';
import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Daftar extends StatefulWidget {
  static bool jenis = false;
  static String poli = "";
  static String id = "";
  const Daftar({Key? key}) : super(key: key);

  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  TextEditingController hp = TextEditingController();
  TextEditingController tgl = TextEditingController();
  String no = "";
  String tanggal = "";

  void lanjut() async {
    setState(() {
      DetailTiket.poli = Daftar.poli;
      DetailTiket.tanggal = tanggal;
      DetailTiket.hp = hp.text;
    });
    if (Daftar.jenis) {
      try {
        var hasil = await http
            .post(Uri.parse("http://10.0.2.2/rs/insertpasien.php"), body: {
          "nama": Pasien.nama.toLowerCase(),
          "tempat": Pasien.tempat.toLowerCase(),
          "tanggal": Pasien.tgl_lahir.toLowerCase()
        });

        var has =
            await http.get(Uri.parse("http://10.0.2.2/rs/caripasien.php"));
        List l = jsonDecode(has.body);
        setState(() {
          DetailTiket.rm = l[0]['rm'].toString();
          DetailTiket.jenis = "pasien baru";
        });
      } catch (err) {
        print(err);
      }
    } else {
      setState(() {
        DetailTiket.jenis = "pasien lama";
      });
    }
    var hasil = await http.post(Uri.parse("http://10.0.2.2/rs/getnomer.php"),
        body: {"poli": Daftar.poli.toLowerCase(), "tanggal": tanggal});
    List list = jsonDecode(hasil.body);
    setState(() {
      no = Daftar.id + "-" + (list[0]['nomor'] + 1).toString().padLeft(3, '0');
    });

    var res =
        await http.post(Uri.parse("http://10.0.2.2/rs/inserttiket.php"), body: {
      "rm": DetailTiket.rm,
      "no": no.toLowerCase(),
      "jenis": DetailTiket.jenis.toLowerCase(),
      "hp": DetailTiket.hp,
      "tanggal": tanggal.toLowerCase(),
      "poli": Daftar.poli.toLowerCase()
    });
    setState(() {
      DetailTiket.no = no;
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Tiket()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff406882),
        shadowColor: const Color(0xff406882),
        elevation: 0,
        title: const Text("Langkah 4/4"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Poliklinik()),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 100,
                width: 100,
                child: Image(
                    fit: BoxFit.fill, image: AssetImage("assets/done.png")),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "SELANGKAH LAGI",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Kami membutuhkan nomor kontak untuk memverifikasi pendaftaran Anda",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Nomor Kontak",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: TextField(
                          controller: hp,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 12)),
                          ),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Tanggal Kunjungan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: TextField(
                          controller: tgl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 12),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 3)));
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat("EEE, d MMMM y", "id_ID")
                                      .format(pickedDate);
                              setState(() {
                                tgl.text = formattedDate;
                                tanggal =
                                    DateFormat("y-MM-d").format(pickedDate);
                              });
                            }
                          },
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffE4CDA7),
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 5),
                        onPressed: lanjut,
                        child: const Text(
                          "DAFTAR SEKARANG",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 90,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Pasien {
  static String nama = "";
  static String tempat = "";
  static String tgl_lahir = "";
  static String tglformat = "";
}
