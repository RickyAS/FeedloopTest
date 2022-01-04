//
//  MainViewModel.swift
//  Feedloop
//
//  Created by Ricky Austin on 04/01/22.
//

import Foundation

protocol MainProtocol: AnyObject{
    func updateView()
    func displayAlert()
}

class mainViewModel{
    
    weak var delegate: MainProtocol?
    
    var person = [PersonModel]()
    
    func retriveData(page: Int){
        UrlService.shared.getPersonList(page: page) { result in
            DispatchQueue.main.async { [self] in
                switch result{
                case .success(let person):
                    self.person = person
                    delegate?.updateView()
                case .failure(let error):
                    print(error)
                    delegate?.displayAlert()
                }
            }
        }
    }
}
