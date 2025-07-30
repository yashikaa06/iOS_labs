//
//  MiddleViewController.swift
//  orderOfEvents
//
//  Created by Yashika Geed on 30/07/25.
//

import UIKit

class MiddleViewController: UIViewController {

    @IBOutlet weak var MiddleLabel: UILabel!
    var eventNumber : Int = 1
    func addEvent(from: String){
        if let existingText = MiddleLabel.text {
            MiddleLabel.text = "\(existingText)\nEvent Number (eventNumber) was \(from)"
            eventNumber += 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvent(from: "viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addEvent(from: "viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addEvent(from: "viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addEvent(from: "viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addEvent(from: "viewDidDisappear")
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
