//
//  ViewController.swift
//  inzure
//
//  Created by Ruben Cuadra on 6/3/17.
//  Copyright © 2017 Ruben Cuadra. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBAction func asegurar(_ sender: Any)
    {
        var processor  = shell( "sysctl","-n","machdep.cpu.brand_string")
        let serial = ViewController.macSerialNumber()
        let specs  = shell( "system_profiler","SPHardwareDataType").components(separatedBy: CharacterSet.newlines)
        var identifier = ""
        var memory = ""
        var uuid = ""
        
        for s in specs
        {
            if s.range(of:"Model Identifier:") != nil
            {
                
                identifier = (s.trim())
                identifier = identifier[identifier.index(identifier.startIndex, offsetBy: 18)..<identifier.endIndex]
            }
            else if s.range(of:"Memory:") != nil
            {
                memory = (s.trim())
                memory = memory[memory.index(memory.startIndex, offsetBy: 8)..<memory.endIndex]
            }
            else if s.range(of:"UUID") != nil
            {
                uuid = (s.trim())
                uuid = uuid[uuid.index(uuid.startIndex, offsetBy: 15)..<uuid.endIndex]
            }
            
        }
        
        var request = URLRequest(url: URL(string: "https://fcf11db2.ngrok.io/api/v1/mac/")!)
        request.httpMethod = "POST"
        let postString = "model=\(identifier)&proc=\(processor)&memory=\(memory)&serial=\(serial)&uuid=\(uuid)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func shell( _ args: String... ) -> String
    {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
    }
    
    static func macSerialNumber() -> String {
        
        // Get the platform expert
        let platformExpert: io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
        
        // Get the serial number as a CFString ( actually as Unmanaged<AnyObject>! )
        let serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0);
        
        // Release the platform expert (we're responsible)
        IOObjectRelease(platformExpert);
        
        // Take the unretained value of the unmanaged-any-object
        // (so we're not responsible for releasing it)
        // and pass it back as a String or, if it fails, an empty string
        return (serialNumberAsCFString!.takeUnretainedValue() as? String) ?? ""
        
    }
}

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
}
