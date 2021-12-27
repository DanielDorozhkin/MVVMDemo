//
//  HomeViewController.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    
    //MARK: -OUTLETS
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var passedButton: UIButton!
    
    private let homeViewModel : HomeViewModel
    private var colorTapCounter : Int = 0
    
    //MARK: -INIT
    required init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: nil)
        
        homeViewModel.homeDelegate = self
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
        passedButtonAnimation()
    }
    
    //MARK: -VC CONFIGURE
    private func VCConfigure() {
        colorTapConfigure()
        UIConfigure()
    }
    
    private func UIConfigure() {
        startButtonConfigure()
        passedButtonConfigure()
    }
    
    private func startButtonConfigure() {
        startButton.setTitleColor(.black, for: .normal)
        
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 2
        startButton.backgroundColor = .yellow
    }
    
    private func passedButtonConfigure() {
        passedButton.backgroundColor = .systemGreen
        passedButton.layer.cornerRadius = 10
        
        passedButton.shadow()
    }
    
    //MARK: -UI UPDATE
    func updateButtonText(_ text: String) {
        startButton.setTitle(text, for: .normal)
    }
    
    private func passedButtonAnimation() {
        guard let label = self.passedButton.titleLabel else { return }
        label.pulsate()
    }
    
    //MARK: -ACTION
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let fieldVC = FieldViewController(viewModel: homeViewModel)
        self.navigationController?.pushViewController(fieldVC, animated: true)
    }
    
    @IBAction func passedButtonTapped(_ sender: UIButton) {
        let currentNumber = getCurrentNumber()
        let model = ImagesViewModel(number: currentNumber)
        
        let imagesVC = ImagesViewController(viewModel: model)
        self.navigationController?.pushViewController(imagesVC, animated: true)
    }
    
    private func getCurrentNumber() -> Int {
        if let text = startButton.titleLabel?.text {
            if let num = Int(text) {
                return num
            }
        }
        
        return 0
    }
}

//MARK: -COLOR TAP
extension HomeViewController {
    func colorTapConfigure() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func tapAction() {
        colorTapCounter += 1
        colorTapUpdate()
    }
    
    private func colorTapUpdate() {
        if colorTapCounter == 6 {
            colorTapCounter = 0
            view.backgroundColor = .random()
        }
    }
}