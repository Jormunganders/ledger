import 'develop.dart';

/**
 * 是否在生产环境
 */
_isInProduction() => bool.fromEnvironment("dart.vm.product");

isInProduction() =>
    bool.fromEnvironment("dart.vm.product") &&
    isFeatureDisable("feature_debug_mode");
