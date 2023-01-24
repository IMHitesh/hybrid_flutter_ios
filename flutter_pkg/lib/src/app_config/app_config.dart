enum Env { development, stagging, production }

class Config {
  static Env env = Env.development;
  static String api = "https://gorest.co.in/public/v2/users";
  static String androidPackageName = "com.fitlab.fast";
  static String iosAppId = "com.fitlab.fast";

  static setupAppConfig(Map<String, dynamic>? data) {
    if (data?["env"] != null) {
      env = Env.values.byName(data?["env"]);
    }

    if (data?["api"] != null) {
      api = data?["api"];
    }

    if (data?["iosAppId"] != null) {
      iosAppId = data?["iosAppId"];
    }

    if (data?["androidPackageName"] != null) {
      androidPackageName = data?["androidPackageName"];
    }
  }
}
