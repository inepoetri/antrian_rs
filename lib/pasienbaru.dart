// ignore_for_file: unused_import

import 'package:antrian_rs/daftar.dart';
import 'package:flutter/material.dart';
import './homepage.dart';
import './poliklinik.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

class PasienBaru extends StatefulWidget {
  const PasienBaru({Key? key}) : super(key: key);

  @override
  _PasienBaruState createState() => _PasienBaruState();
}

class _PasienBaruState extends State<PasienBaru> {
  TextEditingController nama = TextEditingController();
  TextEditingController tgl = TextEditingController();
  TextEditingController tempat = TextEditingController();

  void lanjut() {
    if (nama.text == "" || tgl.text == "" || tempat.text == "") {
      dialogdata();
    } else {
      setState(() {
        Pasien.nama = nama.text;
        Pasien.tempat = tempat.text;
        Pasien.tglformat = tgl.text;
        Poliklinik.before = false;
        Daftar.jenis = true;
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Poliklinik()),
          (Route<dynamic> route) => false);
    }
  }

  void kembali() {
    setState(() {
      Pasien.nama = "";
      Pasien.tempat = "";
      Pasien.tglformat = "";
      Pasien.tgl_lahir = "";
      Poliklinik.before = true;
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false);
  }

  Future<void> dialogdata() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data belum lengkap'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Mohon lengkapi data anda!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    nama.text = Pasien.nama;
    tempat.text = Pasien.tempat;
    tgl.text = Pasien.tglformat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff406882),
        shadowColor: const Color(0xff406882),
        elevation: 0,
        title: const Text("Langkah 2/4"),
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
              const Spacer(flex: 2),
              const Text(
                "PASIEN BARU",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: const Text(
                  "Lengkapi identitas diri Anda untuk memudahkan petugas kami mengidentifikasi Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.55,
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
                        "Nama Lengkap",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.63,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: nama,
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
                        "Tempat Lahir",
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
                            controller: tempat,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 12)),
                            ))),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Tanggal Lahir",
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
                          controller: tgl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 12)),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2020),
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat("EEE, d MMMM y", "id_ID")
                                      .format(pickedDate);
                              setState(() {
                                tgl.text = formattedDate;
                                Pasien.tgl_lahir =
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
                            elevation: 5),
                        onPressed: lanjut,
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
                height: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}
