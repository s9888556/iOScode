//
//  ViewController.swift
//  XylophoneApp_code
//
//  Created by Сергей П on 28.08.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var nameButtons = ["C", "D", "E", "F", "G", "A", "B"]
    private var buttonStackView = UIStackView()
    
    private var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
        createButtons()
    }
    
    private func createButtons() {
        for (index, nameButton) in nameButtons.enumerated() {
            let multiplierWidth = 0.97 - (0.03 * Double(index))
            createButton(name: nameButton, width: multiplierWidth)
        }
    }
    
    private func createButton(name: String, width: Double) {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(name, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 45)
        button.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(button)
        button.layer.cornerRadius = 10
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: width).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.backgroundColor = getColor(for: name)
    }
    
    private func getColor(for name: String) -> UIColor {
        switch name {
        case "C": return .systemRed
        case "D": return .systemOrange
        case "E": return .systemYellow
        case "F": return .systemGreen
        case "G": return .systemIndigo
        case "A": return .systemBlue
        case "B": return .systemPurple
        default: return .white
        }
    }
    
    func togleButtonAlpha(_ button: UIButton) {
        button.alpha = button.alpha == 1 ? 0.5 : 1
    }
    
    func playSound(_ buttonText: String) {
        guard let url = Bundle.main.url(forResource: buttonText, withExtension: "wav") else { return }
        print(url)
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @objc private func buttonsTapped(_ sender: UIButton) {
        togleButtonAlpha(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.togleButtonAlpha(sender)
        }
        guard let buttonText = sender.currentTitle else { return }
        print(buttonText)
        playSound(buttonText)
    }
}

extension ViewController {
    
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(buttonStackView)
        buttonStackView.alignment = .center
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
}
