# A dumb bot for Alice Dialogs

An example bot for Alice Dialogs that offers to buy an elephant. In essence, it's just a rewrite of the [Python Version](https://tech.yandex.ru/dialogs/alice/doc/quickstart-python-docpage/).

The following will clone and build an empty starter project and launch the server on port 8181.
```
swift build
.build/debug/AliceBuyElephant
```

You should see the following output:
```
[INFO] Starting HTTP server localhost on 0.0.0.0:8181
```

This means the server is running and waiting for connections. Send a post request according to the [Docs](https://tech.yandex.ru/dialogs/alice/doc/protocol-docpage/) to http://localhost:8181/v1/alice to get the response. Hit control-c to terminate the server.

A sample request for [AppCode's HTTP Client](https://www.jetbrains.com/help/idea/http-client-in-product-code-editor.html):
```
POST http://localhost:8181/v1/alice
Accept: */*
Cache-Control: no-cache
Content-Type: application/json

{
  "meta": {
    "locale": "ru-RU",
    "timezone": "Europe/Moscow",
    "client_id": "ru.yandex.searchplugin/5.80 (Samsung Galaxy; Android 4.4)"
  },
  "request": {
     "type": "SimpleUtterance",
     "markup": {
        "dangerous_context": true
     },
     "command": "Привет",
     "original_utterance": "Алиса вызови игру купи слона. Привет.",
     "payload": {}
  },
  "session": {
    "new": true,
    "session_id": "2eac4854-fce721f3-b845abba-20d60",
    "message_id": 4,
    "skill_id": "3ad36498-f5rd-4079-a14b-788652932056",
    "user_id": "AC9WC3DF6FCE052E45A4566A48E6B7193774B84814CE49A922E163B8B29881DC"
  },
  "version": "1.0"
}
```

To expose localhost to the internet and test the bot, you might like to use https://ngrok.com. In that case, after setting it up on your machine, start the project and run in the terminal:

```
ngrok http -subdomain=alice_buy_elephant 8181
```

Where the subdomain part may be occupied and should be changed to something more creative.

# Generating an Xcode Project

You may generate an Xcode project to develop and debug in the IDE with the following command in the terminal:

```
swift package generate-xcodeproj
```
