import 'package:flutter/material.dart';
import 'booking_form_screen.dart';
import 'profile_screen.dart';
import 'user_session.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _goToBooking(BuildContext context) async {
    final isLoggedIn = await UserSession.checkLoginStatus();
    if (!isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => BookingFormScreen()));
    }
  }

  void _goToProfile(BuildContext context) async {
    final isLoggedIn = await UserSession.checkLoginStatus();
    if (!isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zona Main'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            tooltip: 'Profil',
            onPressed: () => _goToProfile(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            FutureBuilder<String?>(
              future: UserSession.getUsername(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('');
                }
                return Text(
                  'Halo, ${snapshot.data ?? ''}!',
                  style: TextStyle(fontSize: 18),
                );
              },
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              icon: Icon(Icons.shopping_cart),
              label: Text('Form Pemesanan'),
              onPressed: () => _goToBooking(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
