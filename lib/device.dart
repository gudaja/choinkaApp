import 'dart:io';

class DeviceInfo {
   final InternetAddress _address;
   final String _name;

  DeviceInfo({address,name}):_address = address,_name = name;

   get address => _address;
   get name => _name;
}