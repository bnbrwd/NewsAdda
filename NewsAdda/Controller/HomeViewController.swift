//
//  HomeViewController.swift
//  NewsAdda
//
//  Created by Bindeshwari Narayan on 22/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeTitle: UILabel!
    @IBOutlet weak var homeDescription: UILabel!
    
    var newsDetails : Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitDetails()
    }
    
    func setInitDetails() {
        if let imgString = newsDetails?.urlToImage, !imgString.isEmpty {
            let url = self.newsDetails?.urlToImage ?? ""
            guard let receivedImage = try? Data(contentsOf: URL(string: url ) ?? URL(fileURLWithPath: ""))
            else{ return }
            self.homeImage.image = UIImage(data: receivedImage)
        }
        
        if let titleString = newsDetails?.title, !titleString.isEmpty {
            self.homeTitle.text = titleString
        }
        
        if let descString = newsDetails?.articleDescription, !descString.isEmpty {
            self.homeDescription.text = descString
        }
    }
}
