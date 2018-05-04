//
//  ViewController.swift
//  DemoLoginSocial
//
//  Created by Kai Pham on 5/4/18.
//  Copyright © 2018 Kai Pham. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn

import FBSDKLoginKit

class ViewController: UIViewController {
    let facebookReadPermissions = ["public_profile", "email","user_birthday","user_photos"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnLoginGoogle() {
        loginGG()
    }
    
    @IBAction func btnLoginFacebook() {
        loginFB()
    }
}

extension ViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func loginGG(){
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        
        if configureError != nil {
            print("-------------- Error --------------")
        } else {
            GIDSignIn.sharedInstance().clientID = "1016501746183-ndc0j92vi98oj9pff663873so4b47rnv.apps.googleusercontent.com"
            
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print(user)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("error: \(error)")
    }
    
}

extension ViewController {
    func loginFB() {
        FBSDKLoginManager().logIn(withReadPermissions: facebookReadPermissions, from: self) { (result, error) in
            print(result)
        }
    }
}

