//
//  MainVC.swift
//  DreamLister
//
//  Created by Shashank Kannam on 10/23/16.
//  Copyright © 2016 Shashank Kannam. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
   // @IBOutlet weak var itemCell: tableViewTableViewCell!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var nsFetchController:NSFetchedResultsController<Item>!
    
    let fetchRequest:NSFetchRequest = Item.fetchRequest()
    
    func attemptFetch(){
        
        
        
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        let typeSort = NSSortDescriptor(key: "toItemType.itemType", ascending: true)
        
        if segmentControl.selectedSegmentIndex==0{
          fetchRequest.sortDescriptors = [dateSort]
            sort()
        }
        if segmentControl.selectedSegmentIndex==1{
            fetchRequest.sortDescriptors = [priceSort]
            sort()
        }
        if segmentControl.selectedSegmentIndex==2{
            fetchRequest.sortDescriptors = [titleSort]
            sort()
        }
        if segmentControl.selectedSegmentIndex==3{

            fetchRequest.sortDescriptors = [typeSort]
            sort()
       
    }
    }
    
    
    func sort(){
        nsFetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        nsFetchController.delegate=self
        //self.nsFetchController = nsFetchController
        
        do{
            try nsFetchController.performFetch()
        }
        catch{
            let error = error as NSError
            print(error.debugDescription)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type){
        case .insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        break
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
         break
         
        case .update:
            
                if let indexPath = indexPath{
                let cell = tableView.cellForRow(at: indexPath)
            }
            
            break
        case .move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break

            }
                }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       // generateTestData()
        attemptFetch()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! tableViewTableViewCell
        
        configureCell(cell: cell, index: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configureCell(cell:tableViewTableViewCell, index:NSIndexPath){
      
        //update cell
        let item = nsFetchController.object(at: index as IndexPath)
        
        cell.configureCell(item: item)
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = nsFetchController.sections{
            return sections.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionsN = nsFetchController.sections{
             let sectionInfo = sectionsN[section]
                return sectionInfo.numberOfObjects
            }
          return 0
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = nsFetchController.fetchedObjects, objs.count>0{
            
            let item = objs[indexPath.row]
            
            performSegue(withIdentifier: "itemDewetailsVC", sender: item)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="itemDewetailsVC"{
            if let dest = segue.destination as? ItemDetailsViewController{
                if let s = sender as? Item{
                    dest.item=s
                }
            }
            
    }
    }
    
    
    func generateTestData(){
        let item = Item(context: context!)
        item.title="Lenovo "
        item.price = 500
        item.details="Best in class and price"
        
        let item2 = Item(context: context!)
        item2.title="Macbook "
        item2.price = 1500
        item2.details="highest  in class and price"

        let item3 = Item(context: context!)
        item3.title="benz "
        item3.price = 50000
        item3.details="Best in class and rich look"

        appdelegateShared?.saveContext()
        
    }
    
    @IBAction func sortBYSegment(_ sender: Any) {
        attemptFetch()
        tableView.reloadData()
    }
    
    
    
    }


