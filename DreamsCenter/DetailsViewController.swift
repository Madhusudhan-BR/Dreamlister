//
//  DetailsViewController.swift
//  DreamsCenter
//
//  Created by Madhusudhan B.R on 6/8/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import UIKit
import CoreData
class DetailsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    var stores = [Store]()
    var editableItem: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.dataSource = self
        storePicker.delegate = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let store1 = Store(context: context)
        store1.name = "Amazon"
        
        let store2 = Store(context: context)
        store2.name = "Walmart"
        
        let store3 = Store(context: context)
        store3.name = "Target"
        
        let store4 = Store(context: context)
        store4.name = "Best Buy"
        
        //ad.saveContext()
        
        getNames()
        if editableItem != nil {
            editItem()
        }
        else {
            navigationController?.navigationBar.isHidden = true
        }
    }
    @IBOutlet weak var itemImage: UIImageView!
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false

    }
    
    @IBAction func imageButton(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
      navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if editableItem != nil {
            context.delete(editableItem!)
            ad.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        //let item = Item(context: context) 
        var item:Item!
        var pic = Image(context:context)
        
        if editableItem == nil {
            item = Item(context: context)
        } else {
            item = editableItem
        }
        
        pic.image = itemImage.image
        
        item.toImage = pic
        
        if let details = detailsField.text {
            item.details = details
        }
        if let price = priceField.text {
            var new_price = price as NSString
            item.price = new_price.doubleValue
        }
        if let title = titleField.text {
            item.title = title
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        if editableItem == nil {
        navigationController?.popViewController(animated: true)
        }
        else {
            dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func getNames() {
        let namesFetchRequest : NSFetchRequest<Store> = Store.fetchRequest()
        let dataSort = NSSortDescriptor(key: "name", ascending: true)
            namesFetchRequest.sortDescriptors = [dataSort]
        do{
          self.stores =   try context.fetch(namesFetchRequest)
            storePicker.reloadAllComponents()
        }
        catch {
            let error = error as NSError
            print(error.debugDescription)
        }
    }
    
    func editItem() {
        
        if let item = editableItem {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            itemImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore{
                for index in 0..<stores.count {
                    if store.name == stores[index].name{
                        storePicker.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                }
            }
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImage.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}
