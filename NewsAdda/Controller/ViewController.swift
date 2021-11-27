//
//  ViewController.swift
//  NewsAdda
//
//  Created by Bindeshwari Narayan on 20/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    
    var newsManager = NewsManager()
    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table Registration
        myTable.register(UINib(nibName: "MyTableCell", bundle: nil), forCellReuseIdentifier: "cell")
        showActivityIndicator()
        //indicator
        newsManager.getNewsAPI(completionHandler:) {(success) in
            print(success)
            DispatchQueue.main.async {
                self.myTable.reloadData()
                //closed indicator
                self.hideActivityIndicator()
            }
        }
    }
    // activate indicator
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    //de-activate controller
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsManager.newsArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell creation
        guard let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyTableCell else {
            return UITableViewCell()
        }
        
        cell.setInitCell(article: newsManager.newsArticle[indexPath.row])
        
        return cell
    }
    //to minimize space in footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
    
    //Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.performSegue(withIdentifier: "home", sender: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        vc?.newsDetails = self.newsManager.newsArticle[indexPath.row]
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            
            if let indexPath = self.myTable.indexPathForSelectedRow, !indexPath.isEmpty {
                guard let homeView = segue.destination as? HomeViewController else { return }
                let selectedNews = newsManager.newsArticle[indexPath.row]
                homeView.newsDetails = selectedNews
                self.myTable.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

