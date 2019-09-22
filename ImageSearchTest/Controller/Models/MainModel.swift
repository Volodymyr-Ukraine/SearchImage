//
//  MainModel.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import RealmSwift

class MainModel {
    
    // MARK: -
    // MARK: Properties
    
    public var data: [TableCellsData] = []
    public var toDoIfDataChanges: (()->())?
    private var readedData: InputJSON? = nil
    
    // MARK: -
    // MARK: Init
    
    init() {
        do {
            let realm = try Realm()
            let text = realm.objects(RealmClass.self)
            text.forEach{ (store) in
                let image = UIImage(data: store.file ?? Data(count: 0))
            self.data.append(TableCellsData(name: store.text, image: image))
            }
        } catch {
            print("some error with Realm")
        }
    }
    
    // MARK: -
    // MARK: Public Methods
    
    public func readURL(search: String) {
        var urlComponents = RequestParameters().urlComponents
        urlComponents.queryItems?.append(URLQueryItem(name: "query", value: search))
        guard let urlC = urlComponents.url else { return }
        let request = NSMutableURLRequest(url: urlC,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
            guard let this = self else {return}
            if (error != nil) {
                print("Error: \(String(describing: error))")
            } else {
                guard let rawJSON = data else { return }
                let decoderNames = JSONDecoder()
                do {
                    this.readedData = try decoderNames.decode(InputJSON.self, from: rawJSON)
                    if (this.readedData?.results.first?.urls.small == nil) {
                        this.data.append(TableCellsData(name: "Search '\(search)' get empty result", image: nil))
                        this.toDoIfDataChanges?()
                        return
                    }
                    guard let url = URL(string:  this.readedData?.results.first?.urls.small ?? "") else {
                           print("can't take URL")
                        return
                    }
                    
                    this.downloadImage(from: url){ (rawImage) in
                        this.saveRawImage(name: search, raw: rawImage)
                        let image = UIImage(data: rawImage)
                        this.data.append(TableCellsData(name: search, image: image))
                        this.toDoIfDataChanges?()
                    }
                } catch let err {
                    print("error in decoding JSON: \(err)")
                }
            }
        })
        dataTask.resume()
    }
    
    // MARK: -
    // MARK: Private Methods
    
    private func saveRawImage(name: String, raw: Data) {
        do {
            let realm = try Realm()
            try realm.write {
                let saveData = RealmClass()
                saveData.prepare(search: name, rawImage: raw)
                realm.add(saveData)
            }
        } catch let error {
            print("some error with Realm \(error)")
        }
    }
   
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL, toDo: @escaping (Data)->()) {
        print("Download Started")
        self.getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error in downloading: \(String(describing: error))")
                return
            }
            print("Download Finished")
            DispatchQueue.main.async() {
                toDo(data)
            }
        }
    }
}
