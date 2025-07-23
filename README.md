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
| ![WhatsApp Image 2025-07-23 at 22 26 22_0604dd27](https://github.com/user-attachments/assets/e570c70b-cc3d-4c44-9058-2188012d849b) | ![WhatsApp Image 2025-07-23 at 22 26 22_55c4a5c2](https://github.com/user-attachments/assets/e4be2e98-81e9-41c7-88f1-47ea38ea4c13)| ![WhatsApp Image 2025-07-23 at 22 26 22_07259b2b](https://github.com/user-attachments/assets/7813b997-c910-4a99-92f8-c0e382c0dc1a) |




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



## 🙋‍♂️ About Me

Hi, I'm **Bilal Zulfiqar**, a Software Engineering Student with keen interest in innovation, development, backend integration, and building polished mobile experiences.  
This VPN app is part of my portfolio showcasing my skills in:

- 🔹 Flutter frontend architecture  
- 🔹 API consumption and live UI updates

Feel free to reach out or collaborate! 😊

> **GitHub**: [github.com/ibn-e-zulfiqar]((https://github.com/ibn-e-zulfiqar))  
> **Email**: bilalzulfiqar2004@gmail.com
   
   
