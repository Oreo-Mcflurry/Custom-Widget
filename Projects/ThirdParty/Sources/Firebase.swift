//
//  Firebase.swift
//  ThirdParty
//
//  Created by yooinho on 5/18/25.
//  Copyright © 2025 com.yoo. All rights reserved.
//

import Foundation
import FirebaseAnalytics

public enum Firebase {
    public enum LogEvent: String {
        case setWidget
     
        public static func log(event: LogEvent) {
            Analytics.logEvent(event.rawValue, parameters: nil)
        }
    }
    
    public static func record(error: Error) {
        // Crashlytics.crashlytics().record(error: error)
    }
}

