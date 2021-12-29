//
//  FieldViewController.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit

final class FieldViewController: UIViewController {
    
    //MARK: -OUTLETS
    @IBOutlet private weak var textField:        UITextField!
    @IBOutlet private weak var goButton:         UIButton!
    @IBOutlet private weak var numbersTableView: UITableView!
    
    private let fieldViewModel: FieldViewModelProtocol
    
    //MARK: -INIT
    required init(viewModel: FieldViewModelProtocol) {
        self.fieldViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        fieldViewModel.fieldDelegate = self
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
        if let numberModel = fieldViewModel as? NumbersViewModel {
            textField.text = numberModel.fieldRequestString
        }
    }
    
    
    //MARK: -ACTION
    @IBAction private func goButtonTapped(_ sender: UIButton) {
        fieldViewModel.request(textField.text)
    }
}

//MARK: -TABLE VIEW
extension FieldViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NumberTableViewCell = numbersTableView.dequeueReusableCell(for: indexPath)
        let numberItem = fieldViewModel.itemsSource[indexPath.row]
        
        cell.configure(numberItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fieldViewModel.didSelectRowAt(indexPath: indexPath)
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
