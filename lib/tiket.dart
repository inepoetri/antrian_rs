import 'package:antrian_rs/daftar.dart';
import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: use_key_in_widget_constructors
class Tiket extends StatefulWidget {

  @override
  _TiketState createState() => _TiketState();
}

class _TiketState extends State<Tiket> {
  String no = DetailTiket.no;
  String jenis = "";
  String nama = "";
  String hp = "";
  String tanggal = "";
  String poli = "";
  String rm = DetailTiket.rm;

  @override
  void initState() { 
    super.initState();
    initializeDateFormatting('id_ID', null);
    DateTime tgl = DateFormat("y-MM-d").parse(DetailTiket.tanggal);
    setState(() {
      jenis = DetailTiket.jenis;
      nama = Pasien.nama;
      hp = DetailTiket.hp;
      poli = DetailTiket.poli;
      tanggal = DateFormat("EEE, d MMMM y", "id_ID").format(tgl); 
    });
  }

  void close(){
    DetailTiket.tanggal = "";
    DetailTiket.no = "";
    DetailTiket.jenis = "";
    Pasien.nama = "";
    Pasien.tempat ="";
    Pasien.tgl_lahir ="";
    Pasien.tglformat ="";
    DetailTiket.hp = "";
    DetailTiket.poli = "";
    Navigator.of(context)
      .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomePage()), (Route<dynamic> route) => false);
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
        actions: [IconButton(
          icon: const Icon(Icons.close),
          color: Colors.black,
          onPressed:close
          ),],
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width *0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              const SizedBox(
                height: 90,
                width: 90,
                child: Image(
                  image: AssetImage("assets/done.png"),
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,), 
              const Text(
                "PENDAFTARAN BERHASIL",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 10,),
              const Text(
                "Tunjukkan tiket ini pada petugas kami",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Nomor Antrian",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                no.toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const Text(
                "Nomor RM",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                rm,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Jenis Pasien",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                jenis.toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Nama Pasien",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                nama.toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Nomor HP",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                hp,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Tanggal Kunjungan",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                tanggal.toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Nama Poliklinik",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                poli.toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
            ],
          )
        ],
        
      ),
    );
  }
}

class DetailTiket{
  static String no = "";
  static String jenis = "";
  static String hp = "";
  static String tanggal = "";
  static String poli = "";
  static String rm = "";
}