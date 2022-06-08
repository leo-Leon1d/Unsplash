//
//  PhotoSearchResultVC.swift
//  Unsplash
//
//  Created by Леонид Исраелян on 25.05.2022.
//

import UIKit
import SDWebImage

class PhotoSearchResultVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var notfound: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let CLIENT_ID = "yZyth-jIJp4Xzy6knFju7WuFTkNtZcXe8r1ZyJwzOCk"
    
    var query: String?
    
    var response: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.backgroundColor = .red
        
        
        if let query = query {
            
            fetchImages(with: query)
            
        }
        
        
        
        
    }
    
    
    
    func fetchImages(with query: String) {
        
        let url = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=\(CLIENT_ID)"
        
        /*       guard let escapingString = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
         
         } */
        
        guard let path = URL(string: url) else { return }
        let request = URLRequest(url: path)
        URLSession.shared.dataTask(with: request) { [weak self]
            data, responce, error in
            guard let this = self else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let keys = try JSONDecoder().decode(Model.self, from: data)
                
                this.response = keys.results
                
            }
            
            catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                print(this.response.count)
                this.collectionView.reloadData()
                
                if this.response.count == 0 {
                    this.notfound.text = "Sorry, No Images Found :("
                } else {
                    print("\(this.response.count) images found!")
                }
                
            }
        }
        .resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: view.frame.size.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as! CollectionViewCell
        let item = response[indexPath.row]
        cell.photo.sd_setImage(with: URL(string: item.urls.small), completed: nil)
        return cell
    }
    
    //    func noImagesFound() {
    //
    //        if response.count == 0 {
    //            notfound.text = "Sorry, No Images Found :("
    //        } else {
    //            print("\(response.count) images found!")
    //        }
    //
    //    }
    
    
}
