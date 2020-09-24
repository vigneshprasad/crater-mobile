abstract class Environment {
  static const dev = "dev";
  static const preprod = "preprod";
  static const prod = "prod";
}

abstract class EnvConfigPath {
  static const dev = "config/dev-config.json";
  static const preprod = "config/preprod-config.json";
  static const prod = "config/prod-config.json";
}
