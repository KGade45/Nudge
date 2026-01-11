//
//  ProfileSettingsStore.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 11/01/26.
//

import Foundation

final class ProfileSettingsStore {

    static let shared = ProfileSettingsStore()
    private let key = "profile_settings"

    private init() {}

    func load() -> ProfileSettings {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let settings = try? JSONDecoder().decode(ProfileSettings.self, from: data)
        else {
            return ProfileSettings()
        }
        return settings
    }

    func save(_ settings: ProfileSettings) {
        let data = try? JSONEncoder().encode(settings)
        UserDefaults.standard.set(data, forKey: key)
    }
}

enum ProfileAlarm {
    static let wakeUp = "profile.wakeup"
    static let work = "profile.work"
    static let dinner = "profile.dinner"
}
