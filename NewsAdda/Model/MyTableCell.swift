//
//  MyTableCell.swift
//  NewsAdda
//
//  Created by Bindeshwari Narayan on 20/11/21.
//

import UIKit

class MyTableCell: UITableViewCell {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setInitCell(article: Article?){
        self.myLabel.text = article?.title
        let url = article?.urlToImage ?? ""
        guard let receivedImage = try? Data(contentsOf: URL(string: url ) ?? URL(fileURLWithPath: ""))
        else{
            return
        }
        self.myImage.image = UIImage(data: receivedImage)
        
    }
    
}



