//
//  FieldViewController.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit

class FieldViewController: UIViewController, FieldViewProtocol {
    
    //MARK: -OUTLETS
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var numbersTableView: UITableView!
    
    private let fieldViewModel: FieldViewModel
    
    //MARK: -INIT
    required init(viewModel: FieldViewModel) {
        self.fieldViewModel = viewModel
        super.init(nibName: "FieldViewController", bundle: nil)
        
        viewModel.fieldDelegate = self
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

        VCConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIUpdate()
    }
    
    //MARK: -CONFIGURE
    private func VCConfigure() {
        setKeyboardHidding()
        UIConfigure()
        
        tableViewConfigure()
    }
    
    private func tableViewConfigure() {
        numbersTableView.register(UINib(nibName: "NumberTableViewCell", bundle: nil), forCellReuseIdentifier: "numberCell")
        
        numbersTableView.delegate = self
        numbersTableView.dataSource = self
    }
    
    private func UIConfigure() {
        goButton.backgroundColor = .yellow
        goButton.setTitleColor(.black, for: .normal)
        
        let views : [UIView] = [goButton, textField]
        views.forEach({
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 2
        })
    }
    
    //MARK: -UI UPDATE
    private func UIUpdate() {
        if let request = fieldViewModel.requestModel.requestString {
            textField.text = request
        }
    }
    
    func appearSource() {
        view.backgroundColor = .white
        
        numbersTableView.isHidden = false
        numbersTableView.reloadData()
    }
    
    func appearError() {
        view.backgroundColor = .red
        
        numbersTableView.isHidden = true
    }
    
    //MARK: -ACTION
    @IBAction func goButtonTapped(_ sender: UIButton) {
        fieldViewModel.sourceRequestFrom(textField.text)
    }
}

//MARK: -TABLE VIEW
extension FieldViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldViewModel.tableSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = numbersTableView.dequeueReusableCell(withIdentifier: "numberCell", for: indexPath) as? NumberTableViewCell else {
            return UITableViewCell()
        }
        let numberItem = fieldViewModel.tableSource[indexPath.row]
        
        cell.configure(numberItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fieldViewModel.updateHomeScreenButton(index: indexPath.row)
        
        navigationController?.popViewController(animated: true)
    }
}
