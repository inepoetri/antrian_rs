import 'package:antrian_rs/cari.dart';
import 'package:flutter/material.dart';
import './pasienbaru.dart';
import './pasienlama.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff406882),
        shadowColor: const Color(0xff406882),
        elevation: 0,
        title: const Text("Langkah 1/4"),
        centerTitle: true,
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
                "SELAMAT DATANG",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: const Text(
                  "Sebelum memulai pendaftaran, silahkan memilih jenis pendaftaran yang diinginkan",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 10),
                      primary: Colors.white.withOpacity(0.9)),
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const PasienBaru()),
                      (Route<dynamic> route) => false),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Image(image: AssetImage("assets/pasienbaru.png")),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Pasien Baru",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Pasien yang tidak memiliki nomor rekam medis",
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Color(0xffB8B6B6),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 10),
                      primary: Colors.white.withOpacity(0.9)),
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const PasienLama()),
                      (Route<dynamic> route) => false),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Image(image: AssetImage("assets/pasienlama.png")),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Pasien Lama",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Pasien yang telah memiliki nomor rekam medis",
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Color(0xffB8B6B6),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 10),
                      primary: Colors.white.withOpacity(0.9)),
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Cari()),
                      (Route<dynamic> route) => false),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Image(image: AssetImage("assets/tiket.png")),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Tiket Antrian",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Tunjukkan tiket antrian Anda pada petugas",
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Color(0xffB8B6B6),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              )
            ],
          )
        ],
      ),
    );
  }
}
