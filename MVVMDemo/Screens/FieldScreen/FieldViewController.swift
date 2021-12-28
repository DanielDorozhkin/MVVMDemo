//
//  FieldViewController.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit

final class FieldViewController: UIViewController {
    
    //MARK: -OUTLETS
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var goButton: UIButton!
    
    @IBOutlet private weak var numbersTableView: UITableView!
    
    private let homeViewModel: HomeViewModel
    weak var coordinator: MainCoordinator?
    
    //MARK: -INIT
    required init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        homeViewModel.fieldDelegate = self
    }
    
    convenience init() {
        fatalError()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: -VIEW LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        UIConfigure()
        setKeyboardHiding()
        tableViewConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIUpdate()
    }
    
    //MARK: -CONFIGURE
    private func tableViewConfigure() {
        numbersTableView.register(cellType: NumberTableViewCell.self)
        
        numbersTableView.delegate = self
        numbersTableView.dataSource = self
    }
    
    private func UIConfigure() {
        goButton.backgroundColor = .yellow
        goButton.setTitleColor(.black, for: .normal)
        
        let views : [UIView] = [goButton, textField]
        views.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 2
        }
    }
    
    //MARK: -UI UPDATE
    private func UIUpdate() {
        textField.text = homeViewModel.fieldRequestString
    }
    
    
    //MARK: -ACTION
    @IBAction private func goButtonTapped(_ sender: UIButton) {
        homeViewModel.sourceRequestFrom(textField.text)
    }
}

//MARK: -TABLE VIEW
extension FieldViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NumberTableViewCell = numbersTableView.dequeueReusableCell(for: indexPath)
        let numberItem = homeViewModel.tableSource[indexPath.row]
        
        cell.configure(numberItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeViewModel.didSelectRowAt(indexPath: indexPath)
        coordinator?.pop()
    }
}

//MARK: -FIELD VIEW PROTOCOL
extension FieldViewController: FieldViewProtocol {
    func appearSource() {
        view.backgroundColor = .white
        
        numbersTableView.isHidden = false
        numbersTableView.reloadData()
    }
    
    func appearError() {
        view.backgroundColor = .red
        
        numbersTableView.isHidden = true
    }
}
