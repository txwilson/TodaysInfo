//
//  SportsNews.swift
//  Life
//
//  Created by Tyler Wilson on 4/28/17.
//  Copyright © 2017 Tyler Wilson. All rights reserved.
//

import Foundation

protocol SportsNewsDelegate: class {
    func getSportsNews(data: [String])
}

class SportsNews: NSObject, XMLParserDelegate {
    
    weak var delegate: SportsNewsDelegate?
    
    let url = URL(string: "https://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU")
   
    var title = ""
    var newsTitles = [String]()
    var foundTitle = false
    
    
    
    func setUpParser(){
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            let parser = XMLParser(data: data!)
            parser.delegate = self
            if parser.parse() {
                //print(results)
            }
        }
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "title"{
            foundTitle = true
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        foundTitle = false
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let cleanString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if foundTitle && cleanString != ""{
            title = cleanString
            newsTitles.append(title)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        delegate?.getSportsNews(data: newsTitles)
    }
    
    func getTitles() -> [String]{
        return newsTitles
    }
    
    
}
