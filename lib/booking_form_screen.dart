import 'package:flutter/material.dart';

class BookingFormScreen extends StatefulWidget {
  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? nama;
  String? lamaSewa;
  String? tipePS;
  int harga = 0;

  final List<String> tipePSOptions = ['PS3', 'PS4', 'PS5'];
  final List<String> lamaSewaOptions = ['12 jam', '24 jam'];

  final Map<String, Map<String, int>> hargaSewa = {
    'PS3': {'12 jam': 35000, '24 jam': 70000},
    'PS4': {'12 jam': 45000, '24 jam': 90000},
    'PS5': {'12 jam': 60000, '24 jam': 120000},
  };

  void _updateHarga() {
    if (tipePS != null && lamaSewa != null) {
      setState(() {
        harga = hargaSewa[tipePS!]?[lamaSewa!] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Pemesanan')),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Sewa PlayStation',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nama Pemesan'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Wajib diisi' : null,
                  onSaved: (value) => nama = value,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Lama Sewa'),
                  items: lamaSewaOptions
                      .map((durasi) => DropdownMenuItem(
                            value: durasi,
                            child: Text(durasi),
                          ))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Silakan pilih lama sewa' : null,
                  onChanged: (value) {
                    setState(() {
                      lamaSewa = value;
                      _updateHarga();
                    });
                  },
                  onSaved: (value) => lamaSewa = value,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Pilih Tipe PS'),
                  items: tipePSOptions
                      .map((ps) => DropdownMenuItem(
                            value: ps,
                            child: Text(ps),
                          ))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Silakan pilih tipe PS' : null,
                  onChanged: (value) {
                    setState(() {
                      tipePS = value;
                      _updateHarga();
                    });
                  },
                  onSaved: (value) => tipePS = value,
                ),
                SizedBox(height: 16),
                if (harga > 0)
                  Text(
                    'Harga: Rp ${harga.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _updateHarga();
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Sewa Berhasil'),
                          content: Text(
                              'Terima kasih, $nama\nTipe PS: $tipePS\nLama sewa: $lamaSewa\nHarga: Rp ${harga.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Pesan Sekarang'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
