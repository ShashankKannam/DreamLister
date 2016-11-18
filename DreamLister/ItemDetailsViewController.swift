//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Shashank Kannam on 10/26/16.
//  Copyright © 2016 Shashank Kannam. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imagedetail: UIImageView!
    @IBOutlet weak var storedetail: UIPickerView!
    @IBOutlet weak var titledetail: CustomTextField1!
    @IBOutlet weak var pricedetail: CustomTextField1!
    @IBOutlet weak var commentsdetail: CustomTextField1!
    @IBOutlet weak var thumbpic: UIImageView!
    
    var imagePicker:UIImagePickerController!
    
    @IBAction func imagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            thumbpic.image=img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    var item:Item!
    var stores = [Store]()
    
    var types = [ItemType]()
    
    var editItem:Item?
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        storedetail.dataSource=self
        storedetail.delegate=self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
//        let store1 = Store(context:context!)
//        store1.name="KMart"
//        let store2 = Store(context:context!)
//        store2.name="Amazon"
//        let store3 = Store(context:context!)
//        store3.name="Walmart"
//        let store4 = Store(context:context!)
//        store4.name="Target"
//        let store5 = Store(context:context!)
//        store5.name="Storeshow"
//        let type1 = ItemType(context:context!)
//        type1.itemType="Electronics"
//        let type2 = ItemType(context:context!)
//        type2.itemType="Automobiles"
//        let type3 = ItemType(context:context!)
//        type3.itemType="Home"
//        appdelegateShared?.saveContext()
        
        
        
        
        getStores()
        
        if let topbackItem = self.navigationController?.navigationBar.topItem{
        topbackItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        editItem=item
        if editItem != nil{
            loadData()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component==0{
          return stores.count
        }
        return types.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component==1{
            return types[row].itemType
        }
        return stores[row].name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    }
    
    
    func getStores(){
        let fetchRequest:NSFetchRequest<Store> = Store.fetchRequest()
        let fetchRequest1:NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do{
            self.stores = try context!.fetch(fetchRequest)
            self.types = try context!.fetch(fetchRequest1)
            self.storedetail.reloadAllComponents()
        }
        catch{
            //handle error
            let err = NSError()
            print(err.debugDescription)
        }
    }
    
    
    @IBAction func saveItem(_ sender: UIButton) {
        
        let pic:Image = Image(context: context!)
        
        pic.image = thumbpic.image
        
        
        
        
        var item:Item!
        
        
        
        if editItem == nil{
            item=Item(context: context!)
        }
        else{
            item=editItem
        }
        
        if let title = titledetail.text{
            item.title = title
        }
        if let price = pricedetail.text{
            item.price = Double(price)!
        }
        if let details = commentsdetail.text{
            item.details = details
        }
        item.toImage = pic
        item.toStore = stores[storedetail.selectedRow(inComponent: 0)]
        item.toItemType = types[storedetail.selectedRow(inComponent: 1)]
        appdelegateShared?.saveContext()
        
        navigationController?.popViewController(animated: true)

        
    }
    @IBAction func deleteItem(_ sender: Any) {
        
        if editItem != nil{
           context?.delete(editItem!)
            appdelegateShared?.saveContext()
            
        }
        navigationController?.popViewController(animated: false)
    }

    
    func loadData(){
        
        if let item = editItem{
            titledetail.text=item.title
            pricedetail.text=String(item.price)
            commentsdetail.text=item.details
            thumbpic.image=item.toImage?.image as? UIImage
            
            
            var index = 0
            repeat{
                let store = stores[index]
                
                if let s = item.toStore{
                    if s.name==store.name{
                        storedetail.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                }
                index += 1
            }
            while(index<stores.count)
            
            //
            var index1 = 0
            repeat{
                let type = types[index1]
                
                if let s = item.toItemType{
                    if s.itemType==type.itemType{
                        storedetail.selectRow(index1, inComponent: 1, animated: false)
                        break
                    }
                }
                index1 += 1
            }
                while(index1<types.count)

        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
}
