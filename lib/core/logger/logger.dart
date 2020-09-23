import 'package:sentry/sentry.dart';

abstract class Logger {
  Future<void> captureException({
    dynamic exception,
    StackTrace stackTrace,
  });
}

class LoggerImpl implements Logger {
  final SentryClient sentryClient;

  LoggerImpl(this.sentryClient);

  @override
  Future<void> captureException({
    dynamic exception,
    StackTrace stackTrace,
  }) async {
    await sentryClient.captureException(
      exception: exception,
      stackTrace: stackTrace,
    );
  }
}
