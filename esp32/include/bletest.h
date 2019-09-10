#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLE2902.h>

#define SERVICE_UUID "ab0828b1-198e-4351-b779-901fa0e0371e"
#define MESSAGE_UUID "4ac8a682-9736-4e5d-932b-e9b31405049c"

#define DEVINFO_UUID (uint16_t)0x180a
#define DEVINFO_MANUFACTURER_UUID (uint16_t)0x2a29
#define DEVINFO_NAME_UUID (uint16_t)0x2a24
#define DEVINFO_SERIAL_UUID (uint16_t)0x2a25

#define DEVICE_MANUFACTURER "Foobar"
#define DEVICE_NAME "BLETest"