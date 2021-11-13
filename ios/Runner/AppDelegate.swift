import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var time:Array<Any>?
  var notifications = [String]()
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let center = UNUserNotificationCenter.current()
    center.delegate = self
    center.requestAuthorization(options: [.alert, .badge, .sound]) {(granted, error) in
        if granted{
            print("permission granted")
        }
        else{
            print("permision denied")
        }
    }

    let controller = self.window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "co.moxielabs.dev/alarm", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        guard call.method == "startAlarm" || call.method == "deleteAlarm" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.time = call.arguments as! Array<Any>?
        if (call.method=="startAlarm"){
          self.startAlarmService(result: result)

        }
        else if(call.method == "deleteAlarm"){
            self.deleteAlarm(result: result)
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func startAlarmService(result: FlutterResult) {
    let content = UNMutableNotificationContent()
    let center = UNUserNotificationCenter.current()
    content.title = "Alarm"
    //content.body = "This is an alarm notification"
    content.sound = UNNotificationSound.default
    content.categoryIdentifier = "Local Notification"
    //content.userInfo = ["example": "information"]
    
    let identifier = self.time?[0] as? String ?? "Omg"
    
    var date = DateComponents()
    date.hour = self.time?[1] as? Int
    date.minute = self.time?[2] as? Int
    
    let repeatAlarm = self.time?[3] as? Bool ?? false
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeatAlarm)
    
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    center.add(request)
      result("Alarm Notification is set")
  }
    
  private func removeAllAlarms(result: FlutterResult) {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests();
    result("All notifications deleted")
  }
  
  private func deleteAlarm(result: FlutterResult){
    let identifier = self.time?[0] as? String ?? "Omg"
    
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier] )
    result("Alarm Notification is deleted")
  }
}
