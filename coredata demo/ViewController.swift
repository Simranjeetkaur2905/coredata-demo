//
//  ViewController.swift
//  coredata demo
//
//  Created by Simran Chakkal on 2020-01-16.
//  Copyright © 2020 Simran Chakkal. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //first we create instances of app delegate
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        /*second we need the context
         this context is the manager like location manager , audio manager etc
         
         */
        
        let context = appdelegate.persistentContainer.viewContext
        /*
        // 3rd step-write into context
        let newuser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newuser.setValue("Simran", forKey: "name")
        newuser.setValue(9055199005, forKey: "phone")
        newuser.setValue(25, forKey: "age")
        newuser.setValue("chakkal@gmail.com", forKey: "email")
       // 4th step - save context
        do{
          try  context.save()
            print(newuser,"is saved")
        }
        catch{
            print(error)
        }
       */
        //fetch data and load it
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        request.predicate = NSPredicate(format: "name=%@", "Simran")
        
       // finding chakkalgmail.ca
        request.predicate = NSPredicate(format: "email contains %@", ".ca")
       request.returnsObjectsAsFaults = false
        
        //we find our data
        do{
            let results = try context.fetch(request)
            
            if results.count > 0{
                for result in results as! [NSManagedObject]{
//
                    if let name = result.value(forKey: "name"){
                    print(name)
                    }
                    
                    if let email = result.value(forKey: "email"){
                        print(email)
                        //for update the email to chakkalsimmi@gmail.com
                        
                        let email = email as! String
                        //update core data
                        result.setValue(String(email.dropLast(2)) + "ca", forKey: "email")
                        do{
                          try  context.save()
                            print(result,"is saved")
                        }
                        catch{
                            print(error)
                        }
                        
                    }
  
                    //delete the user suman
                    if let name = result.value(forKey: "name") as? String{
                    context.delete(result)
//
                        do{
                            try context.save()
                        }
                        catch{
                            print(error)
                        }
                        print(name)
                    }
                }

                
            }
        }
        catch{
            print(error)
        }
        
       
    }

}

