//
//  SectionsTableViewController.swift
//  curveBall
//
//  Created by Dojo on 1/24/18.
//  Copyright © 2018 Dojo. All rights reserved.
//

import UIKit
import CoreData
class SectionsTableViewController: UITableViewController {
    var headers = ["FAVORITE QUOTES", "QUOTE BANK"]
    
    var quotes = [Quote]()
    
    var data =  [String: [Quote]]()
    var favQuotes = [Quote]()
    var quoteBank = [Quote]()
    
//    let desc = ["You cannot shake hands with a clenched fist","When the power of love overcomes the love of power the world will know peace", " Peace is not absence of conflict, it is the ability to handle conflict by peaceful means", "The supreme art of war is to subdue the enemy without fighting", "There is nothing permanent except change", "Friends show their love in times of trouble, not in happiness", " Life isn't about finding yourself. Life is about creating yourself","An eye for an eye only ends up making the whole world blind", "Life is not a problem to be solved, but a reality to be experienced", "Try to be a rainbow in someone's cloud", " We can never obtain peace in the outer world until we make peace with ourselves"]
//
//    let author = ["Indira Gandhi", "Jimi Hendrix", "Ronald Reagan", "Sun Tzu", "Heraclitus", "Euripides", "George Bernard Shaw", "Mahatma Gandhi", "Soren Kierkegaard", "Maya Angelou","Dalai Lama"]

    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAll()
        defineSections()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let header = headers[section]
        return data[header]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
        let header = headers[indexPath.section]
        cell.textLabel?.text = data[header]![indexPath.row].desc
        cell.detailTextLabel?.text = data[header]![indexPath.row].author
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var header = headers[indexPath.section]
        let quote = self.data[header]![indexPath.row]
        if !self.data[header]![indexPath.row].isFavourite{
            quote.isFavourite = true
        } else {
            quote.isFavourite = false
        }
        appDelegate.saveContext()
        self.data[header]?.remove(at: indexPath.row)
        
        if header == "QUOTE BANK" {
            header = "FAVORITE QUOTES"
            data[header]?.append(quote)
        }else{
            header = "QUOTE BANK"
             data[header]?.append(quote)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func fetchAll(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Quote")
        do{
            let result = try context.fetch(request)
            quotes = result as! [Quote]
        }
        catch{
            print("\(error)")
        }
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        let header = headers[indexPath.section]
//        let quote = data[header]![indexPath.row]
//        context.delete(quote)
//        appDelegate.saveContext()
//        quotes.remove(at: indexPath.row)
//        defineSections()
//        tableView.reloadData()
//    }

    func defineSections(){
        self.data = [:]
        for quote in quotes{
            var header = "Favorite Quotes"
            if quote.isFavourite{
                header = self.headers[0]
            }
            else{
                header = self.headers[1]
            }
            if (data[header] != nil){
                data[header]?.append(quote)
            }else{
                data[header] = [quote]
            }
        }
    }
    
   
}
