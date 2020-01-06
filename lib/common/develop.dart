/**
 * 开关是否开启
 */
isFeatureEnable(String featureName) => true;

/**
 * 开关是否关闭
 */
isFeatureDisable(String featureName) => true;

class Feature {
  const Feature(String name, String desc, bool defaultValue);
}

const FEATURE_LIST = [
  const Feature("feature_debug_mode", "开启 Debug 模式", false),
];
