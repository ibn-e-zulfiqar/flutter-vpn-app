import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vpn_basic_project/controller/home-controller.dart';
import 'dart:convert';
import '../models/vpn_config.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import 'package:http/http.dart' as http;
import 'location-screen.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  @override
  _StyledVPNScreenState createState() => _StyledVPNScreenState();
}

class _StyledVPNScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _vpnState = VpnEngine.vpnDisconnected;
  List<VpnConfig> _listVpn = [];
  final _controller=Get.put(HomeController());
  VpnConfig? _selectedVpn;
  String _ipAddress = 'Fetching IP...';
  String _selectedServerLocation = 'Please Select';
  String _selectedServerFlagCode = 'N/A'; // Default flag for Optimal Server (e.g., US)
  VpnConfig? _selectedVpnConfig;


  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _getPublicIP();
    // VPN state listener
    VpnEngine.vpnStageSnapshot().listen((event) {
      setState(() => _vpnState = event);
    });

    //initVpn();

    // Shield animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _getPublicIP() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _ipAddress = data['ip'] ?? 'N/A';
        });
      } else {
        setState(() {
          _ipAddress = 'Failed to get IP (${response.statusCode})';
        });
      }
    } catch (e) {
      print('Error fetching public IP: $e');
      setState(() {
        _ipAddress = 'Error: Check internet';
      });
    }
  }

  void _navigateToSelectServer() async {
    final selectedServer = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ServerSelectionScreen()),
    );

    if (selectedServer != null && selectedServer is Map<String, String>) {
      try {
        // Decode the Base64 config string
        final base64Config = selectedServer['Code']!;
        final decodedConfig = utf8.decode(base64.decode(base64Config));

        final vpn = VpnConfig(
          config: decodedConfig,
          country: selectedServer['name'] ?? 'Unknown',
          username: 'vpn',
          password: 'vpn',
        );

        setState(() {
          _selectedServerLocation = selectedServer['name']!;
          _selectedServerFlagCode = selectedServer['flagCode']!;
          _selectedVpn = vpn; // ✅ Assign the newly created VPN config
        });

        _connectClick(); // Optional: auto-connect after selecting
        //_getPublicIP();
        _ipAddress = selectedServer['ip'] ?? 'N/A';
      } catch (e) {
        print("Error decoding VPN config: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to prepare VPN config")),
        );
      }
    }
  }



  Color _getConnectionColor() {
    if (_vpnState == VpnEngine.vpnDisconnected) return Colors.red.shade700;
    if (_vpnState.toLowerCase().contains('connected')) return Colors.green.shade700;
    if (_vpnState.toLowerCase().contains('connecting')) return Colors.orange.shade700;
    return Colors.grey;
  }

  void _connectClick() {
    if (_selectedVpn == null) return;

    if (_vpnState == VpnEngine.vpnDisconnected) {
      VpnEngine.startVpn(_selectedVpn!);
      _animationController.repeat();

    } else {
      VpnEngine.stopVpn();
      _animationController.stop();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Let's Hide",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(0.85),
              Colors.grey.shade900.withOpacity(0.85),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // VPN State Text
                Text(
                  _vpnState.replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _getConnectionColor(),
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: _getConnectionColor().withOpacity(0.5),
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Connect/Disconnect Button
                ElevatedButton(
                  onPressed: _connectClick,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(80),
                    backgroundColor: _getConnectionColor(),
                    shadowColor: _getConnectionColor().withOpacity(0.6),
                    elevation: 15,
                  ),
                  child: RotationTransition(
                    turns: _rotationAnimation,
                    child: const Icon(
                      Icons.shield,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.black.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                    child: Column(
                      children: [
                        const Text(
                          'Your Current IP Address:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _ipAddress,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.black.withOpacity(0.9),
                  child: InkWell(
                    onTap: _navigateToSelectServer, // Navigate on tap
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 15),
                              // Server Location Text
                              Text(
                                _selectedServerLocation,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white60,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // VPN Status
                StreamBuilder<VpnStatus?>(
                  initialData: VpnStatus(),
                  stream: VpnEngine.vpnStatusSnapshot(),
                  builder: (context, snapshot) => Text(
                    "${snapshot.data?.byteIn ?? ""}, ${snapshot.data?.byteOut ?? ""}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(height: 25),

                // VPN Server List

              ],
            ),
          ),
        ),
      ),
    );
  }
}
