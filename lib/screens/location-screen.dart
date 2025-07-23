import 'package:flutter/material.dart';
import '/controller/location-controller.dart';

class ServerSelectionScreen extends StatefulWidget {
  const ServerSelectionScreen({super.key});

  @override
  State<ServerSelectionScreen> createState() => _ServerSelectionScreenState();
}

class _ServerSelectionScreenState extends State<ServerSelectionScreen> {
  final _controller = LocationController();

  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchServers();
  }

  Future<void> _fetchServers() async {
    try {
      await _controller.getVpndata();
      if (_controller.vpnlist.isEmpty) {
        setState(() {
          _error = 'No servers found. Try again later.';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to fetch VPN servers.\n$e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().codeUnits.map((e) => String.fromCharCode(e + 127397)).join();
  }


  Widget _vpnData() => ListView.separated(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    itemCount: _controller.vpnlist.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (ctx, i) {
      final vpn = _controller.vpnlist[i];
      final ping = vpn.ping ?? "N/A";
      final countryCode = vpn.countryShort ?? "??";
      final countryName = vpn.countryLong ?? "Unknown";

      return InkWell(
        onTap: () {
          Navigator.pop(context, {
            'ip': vpn.iP ?? ' ',
            'name': countryName,
            'flagCode': countryCode,
            'Code': vpn.openVPNConfigDataBase64 ?? 'Null',
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                getFlagEmoji(countryCode),
                style: const TextStyle(fontSize: 20),
              ),
            ),

            title: Text(
              vpn.hostName ?? 'No Host',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            subtitle: Text(
              "$countryName  •  Ping: $ping ms",
              style: TextStyle(
                color: ping != "N/A"
                    ? (int.tryParse(ping)! < 150
                    ? Colors.greenAccent
                    : Colors.orangeAccent)
                    : Colors.grey,
                fontSize: 13,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: Colors.white38, size: 16),
          ),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Select Server",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(
          child: CircularProgressIndicator(color: Colors.blueAccent))
          : _error != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _error!,
            style: const TextStyle(
                color: Colors.redAccent, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      )
          : _vpnData(),
    );
  }
}
