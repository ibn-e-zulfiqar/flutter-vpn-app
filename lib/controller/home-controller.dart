import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Vpn.dart';
import 'dart:convert';
import '/services/vpn_engine.dart';

class HomeController extends GetxController{
  final Rx<Vpn?> vpn= null.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;




}