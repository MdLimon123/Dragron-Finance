enum Environment { dev, staging, prod }

class EnvironmentConfig {
  static Environment _current = Environment.dev;

  static Environment get current => _current;

  static void init(Environment env) => _current = env;

  static String get baseUrl {
    switch (_current) {
      case Environment.dev:
        return 'https://s8j2pdrb-8011.inc1.devtunnels.ms/api';
      case Environment.staging:
        return 'https://staging-api.example.com';
      case Environment.prod:
        return 'https://api.example.com';
    }
  }

  static String get baseHost {
    switch (_current) {
      case Environment.dev:
        return 'https://s8j2pdrb-8011.inc1.devtunnels.ms';
      case Environment.staging:
        return 'https://staging-api.example.com';
      case Environment.prod:
        return 'https://api.example.com';
    }
  }

  static bool get isDev => _current == Environment.dev;
  static bool get isStaging => _current == Environment.staging;
  static bool get isProd => _current == Environment.prod;
}
