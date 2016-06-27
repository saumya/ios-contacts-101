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
    
    var contactObjs:AnyObject = NSObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getAllContacts(sender:AnyObject) {
        print("getAllContacts")
        /*
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
        }*/
        
        /*
        SaumyaUtilContact.requestForAccess{(accessGranted) in
            if accessGranted {
                //appDelegate.showMessage("Granted","Contact Access")
                //self.onGotRequestGrant(callerRef)
                self.onGotRequestGrant()
            }else{
                print("Not Granted!","Contact Access")
            }
        } 
         */
        
        SaumyaUtilContact.requestForAccess { (accessGranted) in
            if accessGranted {
                //appDelegate.showMessage("Granted","Contact Access")
                //self.onGotRequestGrant(callerRef)
                self.onGotRequestGrant()
            }else{
                print("Not Granted!","Contact Access")
            }
        }
        
    }
    public func onGotRequestGrant(){
        print("onGotRequestGrant")
    }
    
    private func getContactsFromUserDevice(store:CNContactStore){
        print("getContactsFromUserDevice")
        do {
            let groups = try store.groupsMatchingPredicate(nil)
            let predicate = CNContact.predicateForContactsInGroupWithIdentifier(groups[0].identifier)
            //let predicate = CNContact.predicateForContactsMatchingName("Joe")
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactEmailAddressesKey]
            
            let contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            self.contactObjs = contacts
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //self.tableView.reloadData()
                self.onGotContacts()
            })
            
        } catch {
            print(error)
        }
    }
    
    private func onGotContacts(){
        print("onGotContacts ============ ")
        print(self.contactObjs)
    }

}

