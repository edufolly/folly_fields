import 'package:flutter/widgets.dart';
import 'package:folly_fields/widgets/error_message.dart';
import 'package:folly_fields/widgets/waiting_message.dart';

///
///
///
class SafeFutureBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final T? initialData;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(
    Object? error,
    StackTrace? stackTrace,
    Widget child,
  )? onError;
  final Widget Function(
    ConnectionState connectionState,
    Widget child,
  )? onWait;
  final String? waitingMessage;

  ///
  ///
  ///
  const SafeFutureBuilder({
    required this.builder,
    this.future,
    this.initialData,
    this.onError,
    this.onWait,
    this.waitingMessage,
    Key? key,
  })  : assert(onWait == null || waitingMessage == null,
            'onWait or waitingMessage must be null.'),
        super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          Widget child = ErrorMessage(
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
          );

          if (onError != null) {
            return onError!(snapshot.error, snapshot.stackTrace, child);
          } else {
            return child;
          }
        }

        if (snapshot.hasData) {
          return builder(context, snapshot.data!);
        }

        Widget child = WaitingMessage(message: waitingMessage);

        if (onWait != null) {
          return onWait!(snapshot.connectionState, child);
        } else {
          return child;
        }
      },
    );
  }
}
