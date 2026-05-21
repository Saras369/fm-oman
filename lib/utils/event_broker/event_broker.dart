part 'event_broker_impl.dart';
part 'events/events.dart';

typedef KEventListenersFilter = bool Function(KEventListener listener);

/// [KEventX] represents an event that can be emitted via [KEventBrokerX] to
/// its listeners.
class KEventX<T> {
  final T? extraData;

  const KEventX({this.extraData});
}

abstract class KEventBrokerX {
  static KEventBrokerX shared = _KEventBrokerXImpl();

  /// Register any object that implements [KEventListener].
  void addListener(KEventListener listener);

  /// [filter] can be used to select specific listeners based on some condition.
  /// If [filter] for a given listener returns `true`, that listener will be selected
  /// for this event's target.
  void emitEvent(KEventX event, {KEventListenersFilter? filter});
}

abstract class KEventListener {
  String get identifier => 'event_listener';

  void onEvent(KEventX event);
}

/// Optimization mixin that informs [KEventBrokerX] to not eliminate listeners
/// that are marked with it.
///
/// This is useful to free up any listeners that are
/// only listening to a one time event and then don't have to be listener anymore.
/// Otherwise, keeping a reference to this listener won't let it to be deallocated
/// from memory.
mixin KKeepAliveEventListenerMixin {}
