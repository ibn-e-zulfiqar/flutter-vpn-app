import 'package:get/get_state_manager/get_state_manager.dart';
import '/Vpn.dart';
import '/apiServers.dart';

class LocationController extends GetxController{
  List <Vpn> vpnlist =[];

  Future<void> getVpndata() async{
    vpnlist=await call.getServers();

  }
}

