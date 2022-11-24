import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSLPinning {
  HttpSSLPinning._();

  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  static Future<http.Client> get _instance async => _clientInstance ??= await _createLECClient;
  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<http.Client> get _createLECClient async {
    try {
      final sslCert = await rootBundle.load('assets/certificates/certificate.pem');
      SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

      final client = HttpClient(context: securityContext);
      client.badCertificateCallback = (cert, host, port) => false;

      IOClient ioClient = IOClient(client);
      return ioClient;
    } on TlsException {
      rethrow;
    }
  }
}
