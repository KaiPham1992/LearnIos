//
//  ViewController.swift
//  DemoGCD
//
//  Created by Kai Pham on 4/13/18.
//  Copyright © 2018 Kai Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        serialQueue()
//        concurrentQueue()
//        testDeadlock1()
//        testDeadlock2()
        dispathAfter()
    }
    
    
    func dispathAfter() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("dispath after")
        }
    }
    
    func testDeadlock1() {
        DispatchQueue.main.sync {
            print("never run this code")
        }
    }
    
    func testDeadlock2() {
       let serialQueue = DispatchQueue(label: "serial")
       serialQueue.sync {
            print("Waiting ....")
                serialQueue.sync {
                    print("never runt this code")
                }
            print("Done")
        }
    }
    
    // - Serial Queue (hàng đợi tuần tự)
    func serialQueue() {
        let serialQueue = DispatchQueue(label: "Serial")
//        let serialQueue = DispatchQueue.main
        
        for i in 0...10 {
            serialQueue.async {
                print("Serial: \(i)")
            }
        }
    }
    
    func concurrentQueue() {
        let concurrentQueue = DispatchQueue(label: "Concurrent", attributes: [.concurrent])
//        let concurrentQueue = DispatchQueue.global()
        var count = 0
        for i in 0...10000 {
            concurrentQueue.async {
                
                print("Concurrent: \(count)")
                count += 1
            }
        }
    }
}


