import UIKit

struct Question {
    let questionText: String
    let options: [String]
    let correctAnswerIndex: Int
}

class QuestionViewController: UIViewController {

    var selectedOptions: [String] = []
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        // imageView.image = UIImage(named: "logo")
        return imageView
    }()

    let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        label.text = "¿Cuál es tu opción preferida?"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    var optionButtons: [UIButton] = []

    var questions: [Question] = []
    var currentQuestionIndex = 0

    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Siguiente", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configurar la vista
        view.backgroundColor = .white

        // Agregar el logo a la vista
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
                   logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200) // Modifica el valor para ajustar verticalmente
               ])
        // Agregar la etiqueta de la pregunta a la vista
        view.addSubview(questionLabel)
        NSLayoutConstraint.activate([
                    questionLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
                    questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                ])
        setupOptionButtons()
        setupNextButton()

        // Configurar las preguntas
        setupQuestions()

        // Mostrar la primera pregunta
        displayQuestion()
    }

    func setupOptionButtons() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        for _ in 0..<5 {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            optionButtons.append(button)
        }
    }

    func setupNextButton() {
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: optionButtons.last?.bottomAnchor ?? questionLabel.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    func setupQuestions() {
        let question1 = Question(questionText: "¿Qué color prefieres?",
                                 options: ["Rojo",
                                           "Azul",
                                           "Verde",
                                           "Amarillo",
                                           "Negro"
                                          ],
                                 correctAnswerIndex: 0)
        
        let question2 = Question(questionText: "¿Cuál es tu animal favorito?",
                                 options: ["Perro",
                                           "Gato",
                                           "Pájaro",
                                           "Elefante",
                                           "Oso"
                                          ],
                                 correctAnswerIndex: 1)
        let question3 = Question(questionText: "¿Qué tipo de comida te gusta más?",
                                 options: ["Pizza",
                                           "Sushi",
                                           "Ensalada",
                                           "Pasta",
                                           "Hamburguesa"],
                                 correctAnswerIndex: 3)
        let question4 = Question(questionText: "¿Cuál es tu estación del año preferida?",
                                 options: ["Primavera",
                                           "Verano",
                                           "Otoño",
                                           "Invierno",
                                           "No tengo preferencia"],
                                 correctAnswerIndex: 2)
        let question5 = Question(questionText: "¿Qué actividad prefieres hacer en tu tiempo libre?",
                                 options: ["Leer",
                                           "Ver películas",
                                           "Salir a caminar",
                                           "Hacer deporte",
                                           "Dormir"],
                                 correctAnswerIndex: 4)

        questions = [question1, question2, question3, question4, question5]
    }


    func displayQuestion() {
        guard currentQuestionIndex < questions.count else {
            displayResult()
            return
        }

        let currentQuestion = questions[currentQuestionIndex]

        guard currentQuestion.options.count == optionButtons.count else {
            return
        }

        questionLabel.text = currentQuestion.questionText

        for (index, button) in optionButtons.enumerated() {
            button.setTitle(currentQuestion.options[index], for: .normal)
            button.backgroundColor = UIColor.clear // Restablece el color del botón a transparente
        }
    }


    func displayResult() {
        guard currentQuestionIndex == questions.count else { return }

        let characters: [String: String] = [
            "RojoGatoSushiInviernoOtoñoVer películas": "Mickey Mouse",
            "AzulPerroPizzaVeranoLeer": "Minnie Mouse",
            "VerdePájaroEnsaladaPrimaveraSalir a caminar": "Goofy",
            "AmarilloElefantePastaHacer deporte": "Donald Duck",
            "NegroOsoHamburguesaNo tengo preferencia": "Pluto"
        ]

        let userAnswers = selectedOptions.joined()
        print(selectedOptions)
        var matchedCharacter = "No se pudo determinar el personaje."

        for (characterAnswers, character) in characters {
            let matchingCount = zip(characterAnswers, userAnswers).filter { $0 == $1 }.count
            if matchingCount >= 4 {
                matchedCharacter = character
                break
            }
        }
        
        let resultViewController = ResultController()
            resultViewController.characterName = matchedCharacter
        
        switch matchedCharacter {
            case "Mickey Mouse":
                resultViewController.characterDescription = "Mickey Mouse es un personaje icónico creado por Walt Disney. Es conocido por su personalidad amistosa y su espíritu aventurero. Siempre está listo para nuevas experiencias y es el líder de su grupo de amigos."
            case "Minnie Mouse":
                resultViewController.characterDescription = "Minnie Mouse es la encantadora compañera de Mickey. Es dulce, inteligente y siempre está lista para ayudar a sus amigos. Con su estilo propio, es conocida por ser una verdadera dama."
            case "Donald Duck":
                resultViewController.characterDescription = "Donald Duck es un pato alegre pero a veces temperamental. Aunque puede ser impulsivo, tiene un gran corazón y está siempre dispuesto a cuidar de sus seres queridos."
            case "Goofy":
                resultViewController.characterDescription = "Goofy es un personaje extremadamente amable y un poco torpe. A pesar de ser un poco distraído, tiene un corazón enorme y siempre intenta hacer reír a todos."
            case "Pluto":
                resultViewController.characterDescription = "Pluto es el fiel perro de Mickey. Aunque no habla, su lealtad y amistad son invaluables. Es un perro juguetón y cariñoso que siempre está listo para la aventura."
            default:
                resultViewController.characterDescription = "No se pudo encontrar la descripción para este personaje."
        }
        
        selectedOptions = []
        resultViewController.modalPresentationStyle = .fullScreen
        present(resultViewController, animated: true, completion: nil)
        print("¡Tu personaje es \(matchedCharacter)!")
    }


    @objc func optionSelected(_ sender: UIButton) {
            let selectedButtonIndex = optionButtons.firstIndex(of: sender) ?? 0

            guard currentQuestionIndex < questions.count else {
                displayResult()
                return
            }

            let currentQuestion = questions[currentQuestionIndex]

            guard selectedButtonIndex < currentQuestion.options.count else {
                return
            }

            let selectedOption = currentQuestion.options[selectedButtonIndex]
            selectedOptions.append(selectedOption) // Guardar la opción seleccionada en el arreglo

        currentQuestion.options.indices.forEach { index in
               if index == selectedButtonIndex {
                   optionButtons[index].backgroundColor = UIColor(red: 253.0/255.0, green: 237.0/255.0, blue: 91.0/255.0, alpha: 1.0) // Cambio a #FDED5B
               } else {
                   optionButtons[index].backgroundColor = .clear
               }
           }

            nextButton.isEnabled = true // Habilita el botón "Siguiente"

        }


    @objc func nextButtonTapped() {
        currentQuestionIndex += 1
        displayQuestion()
    }
}

