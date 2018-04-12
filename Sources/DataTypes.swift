//
//  DataTypes.swift
//  AppPackageDescription
//
//  Created by Stanislav Sidelnikov on 4/12/18.
//

import Foundation

struct UserMeta: Codable {
    let locale: String
    let timezone: String
    let clientId: String

    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"

        case locale
        case timezone
    }
}

struct UserRequest: Codable {
    let type: String
    let command: String
    let originalUtterance: String

    enum CodingKeys: String, CodingKey {
        case originalUtterance = "original_utterance"

        case type
        case command
    }
}

struct AliceRequest: Codable {
    struct Session: Codable {
        let new: Bool
        let sessionId: String
        let messageId: Int
        let skillId: String
        let userId: String

        enum CodingKeys: String, CodingKey {
            case sessionId = "session_id"
            case messageId = "message_id"
            case skillId = "skill_id"
            case userId = "user_id"

            case new
        }
    }
    let version: String
    let session: Session
    let request: UserRequest
}

struct ResponseButton: Codable {
    let title: String
    let url: String?
    let hide: Bool
}

struct BotResponse: Codable {
    let text: String
    /// Response text in the Text-To-Speech format
    let tts: String?
    let buttons: [ResponseButton]
    let endSession: Bool

    enum CodingKeys: String, CodingKey {
        case endSession = "end_session"

        case text
        case buttons
        case tts
    }
}

struct AliceResponse: Codable {
    struct Session: Codable {
        let sessionId: String
        let messageId: Int
        let userId: String

        enum CodingKeys: String, CodingKey {
            case sessionId = "session_id"
            case messageId = "message_id"
            case userId = "user_id"
        }

        init(requestSession: AliceRequest.Session) {
            self.sessionId = requestSession.sessionId
            self.messageId = requestSession.messageId
            self.userId = requestSession.userId
        }
    }

    let version: String
    let session: Session
    let response: BotResponse
}
