import UIKit

class ResultController: UIViewController {

    var characterName: String = ""
    var characterDescription: String = ""
    
    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    let backButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Regresar", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(characterNameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            characterNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        backButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50)
                    
        ])
        
        // Update labels with character information
        characterNameLabel.text = "¡Tu personaje es \(characterName)!"
        descriptionLabel.text = characterDescription
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
            
    }
    
    @objc func backButtonPressed() {
        if let navigationController = self.navigationController {
            navigationController.dismiss(animated: true, completion: nil)
        } else {
            let initialView = ViewController()
            initialView.modalPresentationStyle = .fullScreen
            present(initialView, animated: true, completion: nil)
        }
    }}
