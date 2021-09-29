//
//  AcronymsViewModel.swift
//  AcronymsList
//
//  Created by Sudipta on 29/09/21.
//

import Foundation
class AcronymsViewModel {
    func stringValidation(str: String?) -> Bool {
        if let strAcromine = str, !(strAcromine.isEmpty) {
            return true
        }
        else {
           return false
        }
    }
    
    func getdatafromserver(key:String, completion:@escaping(([AcronymsList]?,String)->()))
      {
        let apiurl = URL(string: baseurl + key)
        URLSession.shared.dataTask(with: apiurl!) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil,err.localizedDescription)
            }
            else
            {
                guard let responsedata = data else {
                    return
                }
                do
                {
                    let response = try JSONDecoder().decode([AcronymsList].self, from: responsedata)
                    completion(response,"data found")
                }
                catch let jsonerror {
                    completion(nil,jsonerror.localizedDescription)
                }
            }
        }.resume()
    }
}

class obserable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T?) {
        self.value = value
    }
    var listener: ((T?) -> Void)?
    func bind(_ listener: @escaping(T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
struct acronymslistviewmodel {
    var acronymslist:  obserable<[Acronymslistcellviewmodel]> = obserable([])
}
struct Acronymslistcellviewmodel {
    var  lf: String
}
