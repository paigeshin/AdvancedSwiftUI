//
//  CloudKitPushNotificationBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/19.
//

import SwiftUI
import CloudKit

class CloudKitPushNotificationBootcampViewModel: ObservableObject {
    
    func requestNotificationPermission() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error {
                print(error)
                return
            }
            
            if success {
                print("Notification Granted")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                return
            }
            
            print("Notification Permissino Failure")
            
        }
        
    }
    
    func subscribeToNotifications() {
        
        let predicate = NSPredicate(value: true)
        
        let subscription = CKQuerySubscription(
            recordType: "Fruits",
            predicate: predicate,
            subscriptionID: "fruit_add_to_database",
            options: .firesOnRecordCreation  // .firesOnRecordCreation, .firesOnce, .firesOnRecordDeletion, .firesOnRecordUpdate
        )
        
        let notification = CKSubscription.NotificationInfo()
        notification.title = "There's a new fruit!"
        notification.alertBody = "Open the app to check your fruits"
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        
        CKContainer.default().publicCloudDatabase.save(subscription) { subscription, error in
            if let error {
                print(error)
                return
            }
            print("Success")
        }
        
    }
    
    func unsubscribeToNotifications() {
//        CKContainer.default().publicCloudDatabase.fetchAllSubscriptions(completionHandler: <#T##([CKSubscription]?, Error?) -> Void#>)
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "fruit_add_to_database") { subscriptionId, error in
            if let error {
                print(error)
                return
            }
            print("Successfully unsubscribed")
        }
    }
    
}

struct CloudKitPushNotificationBootcamp: View {
    
    @StateObject var vm = CloudKitPushNotificationBootcampViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            
            Button("Request notification permission") {
                self.vm.requestNotificationPermission()
            }
            
            Button("Subscribe to notifications") {
                self.vm.subscribeToNotifications()
            }
            
            Button("Unsubscribe to notifications") {
                self.vm.unsubscribeToNotifications()
            }
            
        }
    }
}

struct CloudKitPushNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitPushNotificationBootcamp()
    }
}
