//
//  main.swift
//  AppPackageDescription
//
//  Created by Stanislav Sidelnikov on 4/12/18.
//

import PerfectHTTP
import PerfectHTTPServer

func checkAlice(request: HTTPRequest) throws -> AliceRequest {
    do {
        return try request.decode(AliceRequest.self)
    } catch {
        print(error)
        throw error
    }
}

var sessionStorage = [String: [String]]()
let agreeCommands: [String] = ["ладно", "куплю", "покупаю", "хорошо"]

func aliceHandler(aRequest: AliceRequest) throws -> AliceResponse {
    print("Handling a request")
    let bResp: BotResponse
    if aRequest.session.new {
        sessionStorage[aRequest.session.userId] = ["Не хочу.", "Не буду.", "Отстань!"]
        let text = "Привет! Купи слона!"
        bResp = BotResponse(text: text, tts: nil, buttons: getButtons(for: aRequest.session.userId), endSession: false)
    } else if agreeCommands.contains(aRequest.request.command.lowercased()) {
        let text = "Слона можно найти на Яндекс.Маркете!"
        bResp = BotResponse(text: text, tts: nil, buttons: [], endSession: true)
    } else {
        let text = "Все говорят \"\(aRequest.request.command)\", а ты купи слона!"
        bResp = BotResponse(text: text, tts: nil, buttons: getButtons(for: aRequest.session.userId), endSession: false)
    }

    return AliceResponse(version: aRequest.version, session: .init(requestSession: aRequest.session), response: bResp)

}

private func getButtons(for userId: String) -> [ResponseButton] {
    var buttons: [ResponseButton] = sessionStorage[userId]?.prefix(3).map({ ResponseButton(title: $0, url: nil, hide: true) }) ?? []
    if let items = sessionStorage[userId], items.count > 0 {
        sessionStorage[userId] = Array(items.suffix(from: 1))
    }

    if buttons.count < 2 {
        buttons.append(ResponseButton(title: "Ладно", url: "https://market.yandex.ru/search?text=слон", hide: true))
    }
    return buttons
}

var routes = Routes()
var apiRoutes = TRoutes(baseUri: "/v1", handler: checkAlice)
apiRoutes.add(method: .post, uri: "/alice", handler: aliceHandler)
routes.add(apiRoutes)

do {
    try HTTPServer.launch(name: "localhost", port: 8181, routes: routes)
} catch {
    fatalError("\(error)")
}
