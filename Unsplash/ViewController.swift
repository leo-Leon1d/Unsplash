//
//  ViewController.swift
//  Unsplash
//
//  Created by Леонид Исраелян on 15.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let url = "https://api.unsplash.com/search/photos?page=1&per_page=1&query=кот&client_id=pb4AHq38jJjrIN1UZLV88xdW2ROfuhPxT2w-2DlQ20w"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func findImage(_ sender: Any) {
        
        if searchBar.text != nil && searchBar.text?.isEmpty == false {
            performSegue(withIdentifier: "segue01", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue01", let vc = segue.destination as? PhotoSearchResultVC, let request = searchBar.text, request != "" {
            vc.query = request
        }
    }
}

