import UIKit
import Flutter
import appsflyer_sdk.AppsflyerSdkPlugin
import FirebaseDynamicLinks

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        GeneratedPluginRegistrant.register(with: self)
        
        // if let registrar = self.registrar(forPlugin: "SwiftUserleapFlutterPlugin") {
        //     SwiftUserleapFlutterPlugin.register(with: registrar)
        // }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        AppsFlyerLib.shared().handleOpen(url, options: options)
        
        return true
    }
    
    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        
        return true
    }
    
     override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        super.application(application, continue: userActivity, restorationHandler: restorationHandler)
        
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: restorationHandler as? (([Any]?) -> Void))
        
        return true
        
     }
}
