//
//  HomeViewController.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: -OUTLETS
    @IBOutlet weak var startButton: UIButton!
    
    private let fieldViewModel : FieldViewModel
    
    //MARK: -INIT
    required init(viewModel: FieldViewModel) {
        self.fieldViewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: nil)
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
    
    //MARK: -VC CONFIGURE
    private func VCConfigure() {
        UIConfigure()
    }
    
    private func UIConfigure() {
        startButton.setTitleColor(.black, for: .normal)
        
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 2
        startButton.backgroundColor = .yellow
    }
    
    //MARK: -ACTION
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let fieldVC = FieldViewController(viewModel: fieldViewModel)
        
        self.navigationController!.pushViewController(fieldVC, animated: true)
    }
}
