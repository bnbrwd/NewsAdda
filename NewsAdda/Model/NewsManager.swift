//
//  NewsManager.swift
//  NewsAdda
//
//  Created by Bindeshwari Narayan on 20/11/21.
//

import Foundation

protocol NewsAddaDelegate{
    
    func didFailWithError(error: Error)
}

class NewsManager {
    
    var newsArticle:[Article]=[Article]()

    var delegate: NewsAddaDelegate?
    let newsURL = "https://newsapi.org/v2/everything?q=apple&from=2021-11-17&to=2021-11-17&sortBy=popularity&apiKey=a41c3fa3e4fc4227918bf332dc66c88e"
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    
    
     func getNewsAPI(completionHandler: @escaping CompletionHandler){
        
        if let url = URL(string: newsURL){
            print(url)
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {[weak self] data, resoonse, error in
                if error != nil{
                    self?.delegate?.didFailWithError(error: error!)
                    completionHandler(false)
                    return
                }
                if let safeData = data {
                    //used to convert data into String.
                    //                    let dataString = String(data: safeData, encoding: .utf8)
                    //                    print(dataString)
                    self?.paeseJSON(safeData)
                    completionHandler(true)
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
   
    
    
/*    func getNewsAPI(){
            
            if let url = URL(string: newsURL){
                print(url)
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, resoonse, error in
                    if error != nil{
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    if let safeData = data {
                        self.paeseJSON(safeData)
                    }
                }
                //4. Start the task
                task.resume()
            }
        }
    */
    
     func paeseJSON(_ newsData : Data){
        
        
        let decoder = JSONDecoder()
        do{
            let decodedData =  try decoder.decode(NewsDomaindata.self, from: newsData)
            
            newsArticle.append(contentsOf: decodedData.articles)
            print(newsArticle)
            
        
        }catch {
            delegate?.didFailWithError(error: error)
        }
    }
}
