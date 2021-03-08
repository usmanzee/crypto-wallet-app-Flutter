import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String getApiBaseUrl() {
    String url = env['LOCAL_URL'];
    if (env['APP_ENV'] == 'local') {
      url = env['LOCAL_URL'];
    }
    if (env['APP_ENV'] == 'staging') {
      url = env['STAGING_URL'];
    }
    if (env['APP_ENV'] == 'production') {
      url = env['PRODUCTION_URL'];
    }
    return url;
  }

  static String getWSBaseUrl() {
    String url = env['WS_LOCAL_URL'];
    if (env['APP_ENV'] == 'local') {
      url = env['WS_LOCAL_URL'];
    }
    if (env['APP_ENV'] == 'staging') {
      url = env['WS_STAGING_URL'];
    }
    if (env['APP_ENV'] == 'production') {
      url = env['WS_PRODUCTION_URL'];
    }
    return url;
  }

  static String getApiAppVersion() {
    return env['APP_VERSION'];
  }
}
