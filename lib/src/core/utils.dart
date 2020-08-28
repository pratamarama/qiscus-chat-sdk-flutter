part of qiscus_chat_sdk.core;

Future<void> futurify1(void Function(void Function(QError)) fn) async {
  final completer = Completer<void>();
  fn((error) {
    if (error != null) return completer.completeError(error);
    return completer.complete();
  });
  return completer.future;
}

Future<T> futurify2<T>(void Function(void Function(T, QError)) fn) async {
  final completer = Completer<T>();

  fn((data, error) {
    if (error != null) return completer.completeError(error);
    return completer.complete(data);
  });

  return completer.future;
}

Stream<Out> streamify<Out>(
  SubscriptionFn Function(void Function(Out)) fn,
) async* {
  var controller = StreamController<Out>();
  var subscription = fn((data) {
    controller.sink.add(data);
  });

  controller.onCancel = subscription;
  yield* controller.stream;
}

Task<Either<QError, T>> task<T>(Future<T> Function() cb) {
  return Task(cb).attempt().leftMapToQError();
}

Option<Map<String, dynamic>> decodeJson(String json) {
  return catching(() {
    return jsonDecode(json) as Map<String, dynamic>;
  }).toOption();
}
