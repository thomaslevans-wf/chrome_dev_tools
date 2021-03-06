import 'dart:async';
import '../src/connection.dart';

class InspectorApi {
  final Client _client;

  InspectorApi(this._client);

  /// Fired when remote debugging connection is about to be terminated. Contains detach reason.
  Stream<String> get onDetached => _client.onEvent
      .where((Event event) => event.name == 'Inspector.detached')
      .map((Event event) => event.parameters['reason'] as String);

  /// Fired when debugging target has crashed
  Stream get onTargetCrashed => _client.onEvent
      .where((Event event) => event.name == 'Inspector.targetCrashed');

  /// Fired when debugging target has reloaded after crash
  Stream get onTargetReloadedAfterCrash => _client.onEvent.where(
      (Event event) => event.name == 'Inspector.targetReloadedAfterCrash');

  /// Disables inspector domain notifications.
  Future disable() async {
    await _client.send('Inspector.disable');
  }

  /// Enables inspector domain notifications.
  Future enable() async {
    await _client.send('Inspector.enable');
  }
}
