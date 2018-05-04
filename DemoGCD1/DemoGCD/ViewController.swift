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
//        dispathAfter()
        testDispathGroup()
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
    
    func testDispathGroup() {
        let dispatchGroup = DispatchGroup()
        
        let queue1 = DispatchQueue(label: "queue1", attributes: [.concurrent])
        let queue2 = DispatchQueue(label: "queue2", attributes: [.concurrent])
        
        let work1 = DispatchWorkItem {
            sleep(1)
            print("task 1 done")
            dispatchGroup.leave()
        }
        
        let work2 = DispatchWorkItem {
            sleep(2)
            print("task 2 done")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        queue1.async(execute: work1)
        
        dispatchGroup.enter()
        queue2.async(execute: work2)
        
        // wait 5s
        let result = dispatchGroup.wait(timeout: .now() + 5)
        if result == .success {
            print("success in 5s")
        } else {
            print("Failed in 5s")
        }
    }
}


