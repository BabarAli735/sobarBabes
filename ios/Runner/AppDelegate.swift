import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDvh8npnQNdrlU-Ct_gwwHAaMBBDsJQtag")
    // GMSServices.provideAPIKey("AIzaSyAE0lL2KFW7udD9OcE0_mil88Ws_ZZBFYc")
    FirebaseApp.configure()
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
