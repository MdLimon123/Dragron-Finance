import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketManager {



  static WebSocketChannel? _channel;
  static bool _connected = false;

  static final StreamController<String> _messageController =
  StreamController<String>.broadcast();

  static Stream<String> get messageStream => _messageController.stream;

  static void init(String roomId, String token) {
    if (_connected) return;




    final baseUrl = "wss://s8j2pdrb-8011.inc1.devtunnels.ms";
    // Using the ?token= query parameter as provided in the API response's websocketUrl field
    final uri = Uri.parse("$baseUrl/ws/chat/conversations/$roomId/?token=$token");
    debugPrint("Socket connecting to: $uri");
    try {
      _channel = WebSocketChannel.connect(uri);
      _connected = true;

      _channel!.stream.listen(
            (data) {
          debugPrint('Socket Received: $data');
          _messageController.add(data);
        },
        onError: (error) {
          debugPrint('Socket error: \$error');
          _connected = false;
        },
        onDone: () {
          debugPrint('Socket closed');
          _connected = false;
        },
      );
    } catch (e) {
      debugPrint('Failed to connect to socket: \$e');
    }
  }

  static void emit(Map<String, dynamic> message) {
    debugPrint("Socket emit attempt: $message | Connected: $_connected");
    if (_connected && _channel != null) {
      final encoded = jsonEncode(message);
      debugPrint("Socket emitting: $encoded");
      _channel!.sink.add(encoded);
    } else {
      debugPrint("Socket emit failed: channel is not connected.");
    }
  }

  static void disconnect() {
    if (_connected && _channel != null) {
      _channel!.sink.close();
      _connected = false;
    }
  }
}
