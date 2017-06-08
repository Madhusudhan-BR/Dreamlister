//
//  ViewController.swift
//  DreamsCenter
//
//  Created by Madhusudhan B.R on 6/7/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import UIKit
import  CoreData

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var controller : NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        generateTest()
        attemptFetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let rowsInSection = sections[section]
            return rowsInSection.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configure(cell: cell as! ItemCell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects , objs.count>0 {
            performSegue(withIdentifier: "DetailVC", sender: objs[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            if let destination = segue.destination as? DetailsViewController {
                if let item = sender as? Item {
                    destination.editableItem = item
                }
            }
        }
    }
    
    func configure(cell : ItemCell, indexPath: NSIndexPath) {
        
        let item = controller.object(at: indexPath as IndexPath)
         cell.configureCell(item: item)
        
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        if segmentedControl.selectedSegmentIndex == 0  {
        fetchRequest.sortDescriptors = [dateSort]
            
        } else if segmentedControl.selectedSegmentIndex == 1{
        fetchRequest.sortDescriptors = [priceSort]
            
        } else if segmentedControl.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        }
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self 
        self.controller = controller
        do {
            try controller.performFetch()
        }
        catch {
            let error = error as NSError
            print(error.debugDescription)
        }
        
        
    }
    @IBAction func segmentChanged(_ sender: Any) {
        attemptFetch()
        tableView.reloadData()
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
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .bottom)
            }
            break
        case .delete:
        if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .bottom)
            }
            break
        case .update:
            if let indexPath = newIndexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                //update
                configure(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .bottom)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .bottom)
            }
            break
        }
        
    }
    
    func generateTest() {
        let item1 = Item(context: context)
        item1.title = "Facebook ios Engineer"
        item1.details = "I am going to be an iOS Software dev at FB!"
        item1.price = 100000000
        
        ad.saveContext()
    }
    
}

