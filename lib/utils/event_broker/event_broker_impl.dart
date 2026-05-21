part of 'event_broker.dart';

class _KEventBrokerXImpl implements KEventBrokerX {
  final List<KEventListener> listeners = [];

  /// Register any object that implements [KEventListener].
  @override
  void addListener(KEventListener listener) {
    listeners.add(listener);
  }

  /// [filter] can be used to select specific listeners based on some condition.
  /// If [filter] for a given listener returns `true`, that listener will be selected
  /// for this event's target.
  @override
  void emitEvent(KEventX event, {KEventListenersFilter? filter}) {
    late final List<KEventListener> specificListeners;

    if (filter != null) {
      specificListeners = listeners.where(filter).toList(growable: false);
    } else {
      specificListeners = listeners;
    }

    for (var listener in specificListeners) {
      listener.onEvent(event);
    }

    _removeOneTimeListeners();
  }

  /// Optimization function that eliminates any listeners that are ephemeral
  /// A.K.A one-time listeners that haven't added [KKeepAliveEventListenerMixin]
  /// mixin with themselves.
  void _removeOneTimeListeners() {
    listeners.removeWhere((listener) {
      late final bool isRemovable;

      if (listener is KKeepAliveEventListenerMixin) {
        isRemovable = false;
      } else {
        isRemovable = true;
      }

      return isRemovable;
    });
  }
}
