import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Map<String, WebSocketChannel> clients = {};

Future<Response> onRequest(RequestContext context) async {
  final connectionInfo = context.request.connectionInfo;
  final fullAddress =
      '${connectionInfo.remoteAddress}:${connectionInfo.remotePort}';

  final handler = webSocketHandler((channel, protocol) {
    // TODO: react to new connections.
  });
  return handler(context);
}
