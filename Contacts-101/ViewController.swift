//
//  ViewController.swift
//  Contacts-101
//
//  Created by saumya on 23/06/16.
//  Copyright © 2016 saumya. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getAllContacts() {
        print("getAllContacts")
        
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined {
            // request permission from user
            store.requestAccessForEntityType(.Contacts, completionHandler: {(authorized:Bool,error:NSError?)->Void in
                if authorized {
                    self.getContactsFromUserDevice(store)
                }
            })
        }else{
            self.getContactsFromUserDevice(store)
        }
    }
    
    private func getContactsFromUserDevice(store:CNContactStore){
        print("getContactsFromUserDevice")
    }


}

