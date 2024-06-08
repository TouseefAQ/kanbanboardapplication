class ENV {
  static const mobilistenAndroidAPPKey =
      "KMpfK2lX4yoeVC2dpp7dYRplZGy%2F7eb%2BcjthRceAdyqmRUQmEgsX%2B7QGQHnKH9oCco2x1hw8PIFS3q7gLRXhmr7B9L%2B5W8gyE8IA0L0udBo%3D";
  static const mobilistenAndroidACCESSKey =
      "P7pqix9QObClRruYcjI3lTauvbc7QVS%2FwKyDCK9uOxBxwQsO4TlReIDWdnqVH3%2Fz6eJa4VaPdpjVvh4f2aWujHwkRlFlG9DnXH6LtO1%2FS1Ysvf6PeOG3mLRUnD6mp4ZJGiD%2F6TFtXTdr25o667a5MHw9aMGzAxvZhP%2FqrPX9oXDnl6OFaJazrX0xWhNQQWSgrBIybppwpsQ%3D";
  static const mobilistenIOsAPPKey =
      "KMpfK2lX4yoeVC2dpp7dYRplZGy%2F7eb%2BcjthRceAdyqmRUQmEgsX%2B7QGQHnKH9oCco2x1hw8PIFS3q7gLRXhmr7B9L%2B5W8gyE8IA0L0udBo%3D";
  static const mobilistenIOSACCESSKey =
      "P7pqix9QObClRruYcjI3lTauvbc7QVS%2FwKyDCK9uOxBxwQsO4TlReIDWdnqVH3%2FzFIR05pOKhUEi%2FYI%2BBP%2B%2Fbvi3K28vwe44kLaVNP4j2qcFXvU6mWEcqrRUnD6mp4ZJGiD%2F6TFtXTdr25o667a5MHw9aMGzAxvZhP%2FqrPX9oXDnl6OFaJazrX0xWhNQQWSgrBIybppwpsQ%3D";


  static const UXcamKey = "c0qdpwdhi55rpbd";
  static const appFlyerDevKey = "uYY8iLDJRhYChNrm94riST";
  static const appFlyerAppId = "6446218883";
  static const _appFlyerOneLineDeeplink =
      "https://talabna.onelink.me/DAhS/7xaue57w";

  static String getAppFlyerShareableDeepLink(String params) {
    return "$_appFlyerOneLineDeeplink?deep_link_value=$params&af_force_deeplink=true";
  }

  ///TODO: STRIPE REMOVE
  // static const stripeProductionApiKey = "pk_live_51Mdwl2LdRTNI7wOJEb5KFH4HjUMXeJAgJ5vSAJR6WHGtOSIFkFihSTkHIqmziPQb4XW1oYF4c4qxaqldhG007q2400no1VE7Xz";
  // /// test key is from Touseef Stripe account
  // static const stripeSandBoxApiKey = "pk_test_51Mdwl2LdRTNI7wOJu5rkf8JRGk7PiutVSMp9S3LdsiptUHRAuHKvqBo1PKHlmjo1Ekz103f3OThko4eZ5i2bXTVI00P1e29aWm";

  static const applePayMerchantId = "merchant.ae.talabna.pay";
  static const tapPaymentProductionApi = 'sk_live_jTMzKXsD8ILb7cxnPv1Z396A';
  static const tapPaymentSandBoxApi = 'sk_test_NTlSPMmFEQeLwoAaKBsrfUbR';
  static const appBundleId = 'comm.tablana.food';
  static const tapPaymentProductionWebHookUrl =
      "https://sbu0u3dyle.execute-api.me-central-1.amazonaws.com/default/tap-gateway-prod-webhook";

  ///logs
  static const sentryDSN =
      "https://fa259e8a2a8b4023b1988a3a9ade2640@o4505504097370112.ingest.sentry.io/4505509932564480";

  ///google map api
  static const googleMapApi = "AIzaSyCqN7xooaA3sXkOKoRUVR-XFfB4LwV70XU";

  ///staging webhook
  static const tapPaymentStagingWebHookUrl =  "https://webhook.site/58bf0383-3fd9-4f01-803f-1df1e626dd63" ;
      // "https://e6y8qk722b.execute-api.me-central-1.amazonaws.com/default/tap-gateway-dev-webhook";
  static const stagingCustomerId = "cus_TS05A3420231123Pg620609185";
}
