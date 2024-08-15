//
//  StartViewController.swift
//  Ricers
//
//  Created by Артем Антонов on 15.08.2024.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    @IBAction func startButtonPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
    }
    
    
    // MARK: - Navigation
    
    

}
