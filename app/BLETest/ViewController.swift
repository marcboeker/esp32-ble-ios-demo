import UIKit
import CoreBluetooth

var myPeripheal:CBPeripheral?
var myCharacteristic:CBCharacteristic?
var manager:CBCentralManager?

let serviceUUID = CBUUID(string: "ab0828b1-198e-4351-b779-901fa0e0371e")
let periphealUUID = CBUUID(string: "24517CE4-2DC1-6489-39A4-672BBE4344DF")

class ViewController: UIViewController, CBCentralManagerDelegate {

    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var sendText1Button: UIButton!
    @IBOutlet weak var sendText2Button: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
    }

    @IBAction func scanButtonTouched(_ sender: Any) {
        manager?.stopScan()
        manager?.scanForPeripherals(withServices:[serviceUUID], options: nil)
    }
    
    @IBAction func sendText1Touched(_ sender: Any) {
        sendText(text: "HeyHo")
    }
    
    @IBAction func sendText2Touched(_ sender: Any) {
        sendText(text: "Foobar")
    }
    
    @IBAction func disconnectTouched(_ sender: Any) {
        manager?.cancelPeripheralConnection(myPeripheal!)
    }
    
    func sendText(text: String) {
        if (myPeripheal != nil && myCharacteristic != nil) {
            let data = text.data(using: .utf8)
            myPeripheal!.writeValue(data!,  for: myCharacteristic!, type: CBCharacteristicWriteType.withResponse)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.identifier.uuidString == periphealUUID.uuidString {
            myPeripheal = peripheral
            myPeripheal?.delegate = self
            manager?.connect(myPeripheal!, options: nil)
            manager?.stopScan()
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("Bluetooth is switched off")
        case .poweredOn:
            print("Bluetooth is switched on")
        case .unsupported:
            print("Bluetooth is not supported")
        default:
            print("Unknown state")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([serviceUUID])
        print("Connected to " +  peripheral.name!)
        
        connectButton.isEnabled = false
        disconnectButton.isEnabled = true
        sendText1Button.isHidden = false
        sendText2Button.isHidden = false
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from " +  peripheral.name!)
        
        myPeripheal = nil
        myCharacteristic = nil
        
        connectButton.isEnabled = true
        disconnectButton.isEnabled = false
        sendText1Button.isHidden = true
        sendText2Button.isHidden = true
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error!)
    }
}

extension ViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        myCharacteristic = characteristics[0]
    }
}
