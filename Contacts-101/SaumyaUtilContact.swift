//
//  UtilContact.swift
//  Contacts-101
//
//  Created by saumya on 23/06/16.
//  Copyright © 2016 saumya. All rights reserved.
//
// A class with everything static

import Foundation
import Contacts

public class SaumyaUtilContact {
    
    static var hasContactsFetched:Bool = false
    static var allContacts:Array = [AnyObject]()
    static var contactStore:CNContactStore = CNContactStore()
    
    // MARK: Contacts Request Access
    static func requestForAccess(completionHandler: (accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Authorized:
            completionHandler(accessGranted: true)
            
        case .Denied, .NotDetermined:
            SaumyaUtilContact.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(accessGranted: access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.Denied {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            //self.showMessage(message)
                        })
                    }
                }
            })
            
        default:
            completionHandler(accessGranted: false)
        }
    }
    
    class func getContacts(){
        print("getContacts")
        SaumyaUtilContact.requestForAccess { (accessGranted) in
            if accessGranted {
                //showMessage("Granted","Contact Access")
                //self.onGotRequestGrant(callerRef)
                SaumyaUtilContact.onGotRequestGrant()
            }else{
                //appDelegate.showMessage("Not Granted!","Contact Access")
            }
        }
    }
    
    static func onGotRequestGrant(){
        print("onGotRequestGrant")
        
        do{
            //let contactStore:CNContactStore = AppDelegate.getAppDelegate().contactStore;
            let contactStore:CNContactStore = SaumyaUtilContact.contactStore
            let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNamePrefixKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey]
            //let ccr:CNContactFetchRequest = CNContactFetchRequest(keysToFetch:keys)
            
            //print("Fetching all contacts. Now ============== ")
            try contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch:keys)) { (contact, pointer) -> Void in
                //print(contact)
                allContacts.append(contact)
                hasContactsFetched = true
            }
            //print("Fetching all contacts. Done ============= ")
            //callerRef.gotContacts()
            
            // Post the notification
            let notification = NSNotification(name: "contact_fetch_success", object: self, userInfo:nil )
            NSNotificationCenter.defaultCenter().postNotification(notification)
            
        }catch let error as NSError{
            print(error.description, separator: "", terminator: "\n")
        }
        
        //print("xxxxxxxxxxxxx")
        //print(self.allContacts)
    }
    
    
}