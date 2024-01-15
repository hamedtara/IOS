//
//  Constant.swift
//  Mobogram iOS
//
//  Created by Hamed Tara on 2024-01-11.

//

struct K {
    static let appName = "📩Mobogram"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChatVC"
    static let loginSegue = "LoginToChatVC"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
