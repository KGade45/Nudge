//
//  ProfileSettingsModel.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 11/01/26.
//

import Foundation

struct ProfileSettings: Codable {
    var wakeUpTime: Date?
    var workStartTime: Date?
    var dinnerTime: Date?

    var homeLocation: UserSelectedLocation?
    var officeLocation: UserSelectedLocation?
}
