//
//  FoodTableViewController.swift
//  Meal Tracker
//
//  Created by Yashika Geed on 18/08/25.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    var meals: [Meal] {
           
            let pancakes = Food(name: "Cereal", description: "Cereal in cold milk")
            let eggs = Food(name: "Avacado toast", description: "Toasted bread with butter with avacado on it")
            let coffee = Food(name: "Coffee", description: "Freshly brewed hot coffee")
            let breakfast = Meal(name: "Breakfast", food: [pancakes, eggs, coffee])
            
            let sandwich = Food(name: "Pizza", description: "Margerita Pizza")
            let salad = Food(name: "Salad", description: "Fresh garden salad with dressing")
            let juice = Food(name: "Orange Juice", description: "Chilled orange juice")
            let lunch = Meal(name: "Lunch", food: [sandwich, salad, juice])
            
            let pasta = Food(name: "Pasta", description: "Spaghetti with marinara sauce")
            let steak = Food(name: "Steak", description: "Grilled sirloin steak")
            let wine = Food(name: "Red Wine", description: "Glass of cabernet sauvignon")
            let dinner = Meal(name: "Dinner", food: [pasta, steak, wine])
            
            return [breakfast, lunch, dinner]
        }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let meal = meals[section]
        return meal.food.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath)
                
        let meal = meals[indexPath.section]
        let foodItem = meal.food[indexPath.row]
                
        var content = cell.defaultContentConfiguration()
        content.text = foodItem.name
        content.secondaryText = foodItem.description
        cell.contentConfiguration = content
    
        return cell
    }
    
}

