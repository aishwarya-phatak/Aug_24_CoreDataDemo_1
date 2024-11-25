//
//  ViewController.swift
//  Aug_24_CoreDataDemo_1
//
//  Created by Vishal Jagtap on 25/11/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
//        insertUserRecords()
        retriveUserRecords()
//        deleteUserRecord(name: "User1")
        updateUserRecord(name: "User2")
        retriveUserRecords()
    }
    
    func insertUserRecords(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
//        
//        for i in 1...3{
//            let userManagedObject = NSManagedObject(entity: userEntity!, insertInto: managedContext)
//            userManagedObject.setValue("User\(i)", forKey: "name")
//            userManagedObject.setValue("User\(i)@gmail.com", forKey: "email")
//        }
        
        let userManagedObject1 = NSManagedObject(entity: userEntity!, insertInto: managedContext)
               
               userManagedObject1.setValue("Aniket", forKey: "name")
               userManagedObject1.setValue("Aniket@gmail.com", forKey: "email")
        
        do{
            try managedContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func retriveUserRecords(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        
        do{
            let fetchResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for eachResultObject in fetchResults{
                let name = eachResultObject.value(forKey: "name")
                let email = eachResultObject.value(forKey: "email")
                print("\(name as! String) -- \(email as! String)")
            }
        }catch{
            print("Error \(error.localizedDescription)")
        }
    }
    
    func deleteUserRecord(name : String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        
        let predicate = NSPredicate(format: "name = %@", name)
        
        fetchRequest.predicate = predicate
        
        do{
            let fetchResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            print(fetchResults[0])
            
            let objectToBeDeleted = fetchResults[0]
            managedContext.delete(objectToBeDeleted)
        }catch{
            print(error.localizedDescription)
        }
        
        do{
            try managedContext.save()
        }catch{
            print("error -- \(error.localizedDescription)")
        }
    }
    
    func updateUserRecord(name : String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        
        let predicate = NSPredicate(format: "name = %@", name)
        
        fetchRequest.predicate = predicate
        
        do{
            let fetchResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            let objToBeUpdated = fetchResults[0]
            objToBeUpdated.setValue("User5", forKey: "name")
            objToBeUpdated.setValue("User5@gmail.com", forKey: "email")
            
            do{
                try managedContext.save()
            }catch{
                print("error -- \(error.localizedDescription)")
            }
        }catch{
            print("error -- \(error.localizedDescription)")
        }
    }
}
