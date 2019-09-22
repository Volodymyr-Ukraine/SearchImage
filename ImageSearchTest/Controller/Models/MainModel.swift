//
//  MainModel.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import RealmSwift

class MainModel {
    
    public var data: [TableCellsData] = []
    public var toDoIfDataChanges: (()->())?
    
    
    private var readedData: InputJSON? = nil
    init() {
        //self.readURL(search: "flower")
        do {
        let realm = try Realm()
            let text = realm.objects(RealmClass.self)
            text.forEach{ (store) in
                let image = UIImage(data: store.file ?? Data(count: 0))
            self.data.append(TableCellsData(name: store.text, image: image))
            }
        } catch let error {
            print("some error with Realm")
        }
    }
    
    public func readURL(search: String) {
        let postData = NSMutableData(data: "client_id=a62b141714259e5c3c95d1ecb72a1c7bc162d3a8d03f48d29d3ee3e88526ba21".data(using: String.Encoding.utf8)!)
        postData.append("&query=\(search)".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string:
            "https://api.unsplash.com/search/photos?client_id=a62b141714259e5c3c95d1ecb72a1c7bc162d3a8d03f48d29d3ee3e88526ba21&page=1&query=\(prepareForRequest(string: search))&per_page=1"
            )! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"//"POST"
        //request.allHTTPHeaderFields = headers
        //request.httpBody = postData as Data
        //print(request.httpBody)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
            guard let this = self else {return}
            if (error != nil) {
                print("Error:")
                print(error as Any)
            } else {
                guard let rawJSON = data else { return }
                let decoderNames = JSONDecoder()
                do {
                    this.readedData = try decoderNames.decode(InputJSON.self, from: rawJSON)//.data(using: .utf8)!)
                        print(this.readedData as Any)
                    guard let url = URL(string:  this.readedData?.results.first?.urls.small ?? "") else {
                        print("can't take URL")
                        return
                    }
                    this.downloadImage(from: url){ (rawImage) in
                        do {
                            let realm = try Realm()
                            try realm.write {
                                let saveData = RealmClass()
                                saveData.prepare(search: search, rawImage: rawImage)
                                realm.add(saveData)
                            }
                        } catch let error {
                            print("some error with Realm \(error)")
                        }
                        
                        let image = UIImage(data: rawImage)
                        this.data.append(TableCellsData(name: search, image: image))
                        this.toDoIfDataChanges?()
                        if this.cashImage(name: search, image: image) {
                            print("image \(search).jpg cashed")
                        } else {
                            print("image \(search).jpg didn't cashed")
                        }
                    }
                } catch let err {
                    print("error in decoding JSON: \(err)")
                }
                
            }
        })
        dataTask.resume()
    }
    
   
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL, toDo: @escaping (Data)->()) {
        print("Download Started")
        self.getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error in downloading: \(error)")
                return
            }
            print(response?.suggestedFilename)
            print(url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                toDo(data)
            }
        }
    }
    
    public func cashImage(name: String, image inputImage: UIImage?) -> Bool {
        guard let image = inputImage else {return false}
        guard let data = image.jpegData(compressionQuality: 1) else { return false }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
                return false
            }
        do {
            try data.write(to: directory.appendingPathComponent("\(name).png")!)
            
                return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    public func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }

}
