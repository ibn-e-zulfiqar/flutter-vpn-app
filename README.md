# 🛡️ Ghostline VPN — Flutter VPN App

A modern VPN client built with Flutter and Kotlin. Ghostline VPN connects to [VPNGate](https://www.vpngate.net/) servers in real time, allowing users to browse securely while viewing connection status, server info, and IP changes directly in the app.

> 🔧 This project is based on [nizwar/openvpn_flutter](https://github.com/nizwar/openvpn_flutter), with significant enhancements and native integration.

---

## 🚀 Features

- 🌐 **Real-time VPNGate server list**
  - Fetched dynamically via public API
  - Sorted by country, speed, and uptime
- 🇺🇳 **Country flag display**
  - Automatically shows flags next to server locations
- 📡 **Connect to OpenVPN servers**
  - Native VPN connection using `OpenVPN3` via Kotlin integration
  - No reliance on `flutter_openvpn` package
- 📍 **Live connection status & IP**
  - Fetches current public IP after connection
  - Shows connected server and status updates
- 📱 **Clean, responsive UI**
  - Flutter UI designed with performance and usability in mind
  - Capsule-style server cards with connection indicators

---

## 📱 Screenshots

| Server List | Connection Status | IP Address |
|-------------|-------------------|------------|
| *(Add your screenshots here)* | *(show server selection screen)* | *(show VPN connected status screen)* |

---

## 🛠️ Tech Stack

| Layer         | Technology                            |
|---------------|----------------------------------------|
| Frontend      | Flutter (Dart)                         |
| Native Layer  | Kotlin (Android VPN Integration)       |
| VPN Protocol  | OpenVPN via `de.blinkt.openvpn` lib    |
| API           | [VPNGate API](https://www.vpngate.net/api/iphone/) |
| IP Lookup     | IP-API / Public IP services (on demand) |

---

## 🧠 How It Works

- VPN servers are fetched dynamically from VPNGate's public JSON endpoint.
- When a server is selected, its `.ovpn` config is decoded and passed to the native Android layer.
- Native code uses the OpenVPN3 library (`de.blinkt.openvpn`) to initiate the VPN tunnel.
- Once connected, the app polls for the new public IP and displays live status updates.

---

## 🧑‍💻 Setup & Run

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ibn-e-zulfiqar/flutter-vpn-app
   
