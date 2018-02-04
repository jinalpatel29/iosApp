//
//  CustomSwipeTableViewController.swift
//  curveBall
//
//  Created by Dojo on 1/24/18.
//  Copyright © 2018 Dojo. All rights reserved.
//

import UIKit
import CoreData

class CustomSwipeTableViewController: UITableViewController {
    var heros = [Hero]()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    let characters = ["Batman", "Mario", "Katniss Everdeen", "Thor", "Maggie Simpson"]
//    let nemesis = ["Catwoman", "Bowser", "President Snow", "Loki", "Unibrow Baby"]
//    let world = ["Gotham","Yoshi's Island",  "Panem", "Asgard", "Springfield"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        print(heros)
        fetchAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        let hero = heros[indexPath.row]
        cell.textLabel?.text = hero.name
        let selection = hero.selection

        if selection == "World" {
            cell.detailTextLabel?.text = " \(hero.selection!) : \(hero.world!)"
        }else if selection == "Nemesis"{
            cell.detailTextLabel?.text = " \(hero.selection!) : \(hero.nemesis!)"
        }else{
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let hero = self.heros[indexPath.row]
        let world = UITableViewRowAction(style: .normal, title: "World") { (action, indexPath) in
            print("world button tapped")
            hero.selection = "World"
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        world.backgroundColor = .red
        
        let nemesis = UITableViewRowAction(style: .normal, title: "Nemesis") { (action, indexPath) in
            print("nemesis button tapped")
            hero.selection = "Nemesis"
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        nemesis.backgroundColor = .blue
        
        let clear = UITableViewRowAction(style: .normal, title: "Clear") { (action, indexPath) in
            print("clear button tapped")
            hero.selection = "None"
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        clear.backgroundColor = .lightGray

        do{
            try context.save()
        }catch{
            print("\(error)")
        }
        
        if let selection = hero.selection {
            switch selection {
            case "World":
                return [nemesis, clear]
            case "Nemesis":
                return [world, clear]
            default:
                return [world, nemesis]
            }
        }
        return [world, nemesis]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func fetchAll(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Hero")
        do{
            let result = try context.fetch(request)
            heros = result as! [Hero]
        }catch{
            print("\(error)")
        }
        
    }
}
