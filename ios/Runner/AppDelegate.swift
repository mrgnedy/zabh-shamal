import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    [GMSServices provideAPIKey:@"AIzaSyDyZS1lXwrSQfLucsqjh2_XrT3lm-ZkHjNU"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
