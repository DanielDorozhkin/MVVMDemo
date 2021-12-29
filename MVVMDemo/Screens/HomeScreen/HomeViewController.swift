//
//  HomeViewController.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit
import Reusable

final class HomeViewController: UIViewController {
    
    //MARK: -OUTLETS
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var passedButton: UIButton!
    
    let homeViewModel : HomeViewModel
    
    //MARK: -INIT
    required init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        colorTapConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateButtonsTitles()
        passedButtonAnimation()
        clearTapsCounter()
    }
    
    //MARK: -VC CONFIGURE
    private func UIConfigure() {
        startButtonConfigure()
        passedButtonConfigure()
    }
    
    private func startButtonConfigure() {
        startButton.setTitleColor(.black, for: .normal)
        
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth  = 2
        startButton.backgroundColor    = .yellow
    }
    
    private func passedButtonConfigure() {
        passedButton.backgroundColor    = .systemGreen
        passedButton.layer.cornerRadius = 10
        passedButton.setTitleColor(.white, for: .normal)
        
        passedButton.applyShadow()
    }
    
    private func clearTapsCounter() {
        homeViewModel.colorTapCounter = 0
    }
    
    //MARK: -UI UPDATE
    private func updateButtonsTitles() {
        let goTitle   = homeViewModel.goButtonTitle   ?? "Start!"
        let passTitle = homeViewModel.passButtonTitle ?? "Data passed!"
        
        startButton.setTitle(goTitle, for: .normal)
        passedButton.setTitle(passTitle, for: .normal)
    }
    
    private func passedButtonAnimation() {
        guard let label = self.passedButton.titleLabel else { return }
        label.pulsate()
    }
    
    //MARK: -ACTION
    @IBAction private func startButtonTapped(_ sender: UIButton) {
        homeViewModel.pushFieldScreen()
    }
    
    @IBAction private func passedButtonTapped(_ sender: UIButton) {
        homeViewModel.pushImagesScreen()
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
        homeViewModel.colorTapCounter += 1
        colorTapUpdate()
    }
    
    private func colorTapUpdate() {
        if homeViewModel.colorTapCounter == 6 {
            homeViewModel.colorTapCounter = 0
            view.backgroundColor = .random()
        }
    }
}
