//
//  ViewController.swift
//  Feedloop
//
//  Created by Ricky Austin on 04/01/22.
//

import UIKit

class MainViewController: UITableViewController {
    
    
    private let viewModel = mainViewModel()
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Star Wars"
        view.backgroundColor = .white
        setViewModel()
        setTable()
    }
    
    func setViewModel(){
        viewModel.delegate = self
        viewModel.retriveData(page: currentPage)
    }
    
    func setTable(){
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MainTable")
        
    }
}

extension MainViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.person.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTable", for: indexPath)
        cell.textLabel?.text =  viewModel.person[indexPath.row].name
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

            if offsetY > contentHeight - scrollView.frame.size.height {
                self.currentPage += 1
                viewModel.retriveData(page: currentPage)

            }
    }
    
}

extension MainViewController: MainProtocol{
    
    func updateView() {
        tableView.reloadData()
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "Something is Wrong", message: "There is a problem, please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}


