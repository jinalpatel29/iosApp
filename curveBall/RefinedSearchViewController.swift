//
//  RefinedSearchViewController.swift
//  curveBall
//
//  Created by Dojo on 1/24/18.
//  Copyright © 2018 Dojo. All rights reserved.
//

import UIKit
import CoreData

class RefinedSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var all: UIButton!
    @IBOutlet weak var reptile: UIButton!
    @IBOutlet weak var mammal: UIButton!
    var animals = [Animal]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getAllAnimals(_ sender: UIButton) {
        sender.backgroundColor = UIColor.lightGray
        self.reptile.backgroundColor = .black
        self.mammal.backgroundColor = .black
        fetchAll()
        tableView.reloadData()
    }
    
    @IBAction func getReptiles(_ sender: UIButton) {
        sender.backgroundColor = UIColor.lightGray
        self.all.backgroundColor = .black
        self.mammal.backgroundColor = .black
        fetchCategory(category: "reptile")
        tableView.reloadData()
    }
    
    @IBAction func getMammals(_ sender: UIButton) {
        sender.backgroundColor = UIColor.lightGray
        self.reptile.backgroundColor = .black
        self.all.backgroundColor = .black
        fetchCategory(category: "mammal")
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = animals[indexPath.row].species
        return cell
    }
    
    func fetchAll(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Animal")
        do{
            let result = try managedObjectContext.fetch(request)
            print(result)
            animals = result as! [Animal]
        }
        catch{
            print("(error)")
        }
    }
    
    func fetchCategory(category : String){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Animal")
        let predicate = NSPredicate(format: "category = %@", category)
        request.predicate = predicate
        do{
            let result = try managedObjectContext.fetch(request)
            print(result)
            animals = result as! [Animal]
        }
        catch{
            print("(error)")
        }
    }

}
