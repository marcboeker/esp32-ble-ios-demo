# ESP32 BLE server demo with iOS App

This demo starts a BLE server on your ESP32 and uses an iOS App to send messages to it. The ESP will print the received messages to the serial console.

To use the demo, open the `esp32` folder in [PlatformIO](https://platformio.org/) and compile it for the ESP32. After flashing the ESP32 you can run the iOS app on your device. Make sure to not run it in the simulator, as there is no bluetooth availabe.

Now press `Connect` in the iOS app and wait a little. The app tries to find the BLE device and discovers its services and characteristics. After that you can press the `Send Text 1` or `Send Text 2` button. A short text message will appear in your serial console of your ESP32.

You could also use the [nrf Connect](https://apps.apple.com/us/app/nrf-connect/id1054362403) app to play with the BLE server on your ESP32.

Happy tinkering!
