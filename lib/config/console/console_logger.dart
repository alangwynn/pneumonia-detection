import 'dart:developer' as developer;

final console = _ConsoleLogger();

class _ConsoleLogger {
  _ConsoleLogger();

  /// This method is _used to colorize the terminal output_.
  ///
  /// It can be used to print, debugPrint or return a string.
  void log(
    String text, {
    String name = '',
    String? emoji,
    ColorizerTextColor textColor = ColorizerTextColor.reset,
    ColorizerBackgroundColor backgroundColor = ColorizerBackgroundColor.reset,
  }) {
    _log(
      '${emoji ?? ''} ${textColor.color}${backgroundColor.color}'
      ' $text\x1B[0m',
      name: name,
    );
  }

  /// Shortcut for [log] to display info message.
  void info(
    String text, {
    String name = '',
  }) {
    _log(
      '🗞️ ${ColorizerTextColor.white}${ColorizerTextColor.reset}'
      ' $text\x1B[0m',
      name: name,
    );
  }

  /// Shortcut for [log] to display warning message.
  void warning(
    String text, {
    String name = '',
  }) {
    _log(
      '⚠️ ${ColorizerTextColor.yellow}${ColorizerTextColor.reset}'
      ' $text\x1B[0m',
      name: name,
    );
  }

  /// Shortcut for [log] to display error message.
  void error(
    String text, {
    String name = '',
  }) {
    _log(
      '🚨 ${ColorizerTextColor.red}${ColorizerTextColor.reset}'
      ' $text\x1B[0m',
      name: name,
    );
  }

  void _log(
    String text, {
    String name = '',
    String? emoji,
    ColorizerTextColor textColor = ColorizerTextColor.reset,
    ColorizerBackgroundColor backgroundColor = ColorizerBackgroundColor.reset,
  }) {
    developer.log(
      '${emoji ?? ''} ${textColor.color}${backgroundColor.color}'
              ' $text\x1B[0m'
          .trim(),
      name: name,
    );
  }
}

enum ColorizerTextColor {
  reset('\x1B[39m'),
  black('\x1B[30m'),
  red('\x1B[31m'),
  green('\x1B[32m'),
  yellow('\x1B[33m'),
  blue('\x1B[34m'),
  magenta('\x1B[35m'),
  cyan('\x1B[36m'),
  white('\x1B[37m'),
  gray('\x1B[90m'),
  brightRed('\x1B[91m'),
  brightGreen('\x1B[92m'),
  brightYellow('\x1B[93m'),
  brightBlue('\x1B[94m'),
  brightMagenta('\x1B[95m'),
  brightCyan('\x1B[96m'),
  brightWhite('\x1B[97m');

  const ColorizerTextColor(this.color);
  final String color;
}

enum ColorizerBackgroundColor {
  reset('\x1B[49m'),
  black('\x1B[40m'),
  red('\x1B[41m'),
  green('\x1B[42m'),
  yellow('\x1B[43m'),
  blue('\x1B[44m'),
  magenta('\x1B[45m'),
  cyan('\x1B[46m'),
  white('\x1B[47m'),
  gray('\x1B[100m'),
  brightRed('\x1B[101m'),
  brightGreen('\x1B[102m'),
  brightYellow('\x1B[103m'),
  brightBlue('\x1B[104m'),
  brightMagenta('\x1B[105m'),
  brightCyan('\x1B[106m'),
  brightWhite('\x1B[107m');

  const ColorizerBackgroundColor(this.color);
  final String color;
}