// FlangeDrawingViewController.swift

import UIKit
import Photos

class TransitionViewController: UIViewController {
    
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var schemeNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var dropDownButtons: [UIButton]!
    @IBOutlet var dropDownLabels: [UILabel]!
    @IBOutlet weak var versionButton: UIButton!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var sizeButton: UIButton!
    @IBOutlet weak var classButton: UIButton!
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var parameterButton: UIButton!
    @IBOutlet weak var stackView4: UIStackView!
    
    var screenTitle: String?
    var selectedIndex: Int?
    
    var selectedVersion: String?
    var selectedTitle: String?
    var selectedSize: String?
    var selectedClass: String?
    var selectedType: String?
    var selectedParameter: String?
    
    var configurationDict: [String: FlangeConfiguration] = [:]
    var configurations: [FlangeConfiguration] = []
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    
    let dropDownVersion = DropDown()
    let dropDownTitle = DropDown()
    let dropDownClass = DropDown()
    let dropDownSize = DropDown()
    let dropDownType = DropDown()
    let dropDownParameter = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitles()
        setupNavigationBar()
        findConfiguration()
        
        let configurations = createFlangeConfigurations(
            version: TransitionModel.versionArray,
            title: TransitionModel.titlesArray,
            dn: TransitionModel.dnArray,
            d: TransitionModel.dArray,
            t: TransitionModel.tArray,
            d1: TransitionModel.d1Array,
            t1: TransitionModel.t1Array,
            l: TransitionModel.lArray,
            r: TransitionModel.rArray,
            r1: TransitionModel.r1Array,
            mass: TransitionModel.massArray,
            imageName: TransitionModel.titlesImage,
            label1X: TransitionModel.label1XArray,
            label2X: TransitionModel.label2XArray,
            label3X: TransitionModel.label3XArray,
            label4X: TransitionModel.label4XArray,
            label5X: TransitionModel.label5XArray,
            label6X: TransitionModel.label6XArray,
            label7X: TransitionModel.label7XArray,
            label1Y: TransitionModel.label1YArray,
            label2Y: TransitionModel.label2YArray,
            label3Y: TransitionModel.label3YArray,
            label4Y: TransitionModel.label4YArray,
            label5Y: TransitionModel.label5YArray,
            label6Y: TransitionModel.label6YArray,
            label7Y: TransitionModel.label7YArray,
            flangesArray: TransitionModel.flangesArray,
        )
        self.configurations = configurations
        
        for config in configurations {
            configurationDict[config.key] = config
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateDropDowns()
        findConfiguration()
        setupBorder(labels: dropDownLabels, buttons: dropDownButtons)
    }
    
    
    func updateDropDowns() {
        switch versionButton.titleLabel?.text ?? "" {
        case "Исполнение 1":
            let sortedUniqueDNArray = Array(
                Set(TransitionModel.dnArray.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
            )
            .sorted()
            .map { number -> String in
                if number == number.rounded() {
                    return String(format: "%.0f", number)
                } else {
                    return String(format: "%.1f", number).replacingOccurrences(of: ".", with: ",")
                }
            }

            let sortedUniqueDArray = Array(
                Set(TransitionModel.dArray.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
            )
            .sorted()
            .map { number -> String in
                if number == number.rounded() {
                    return String(format: "%.0f", number)
                } else {
                    return String(format: "%.1f", number).replacingOccurrences(of: ".", with: ",")
                }
            }

            let sortedUniqueTArray = Array(
                Set(TransitionModel.tArray.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
            )
            .sorted()
            .map { number -> String in
                if number == number.rounded() {
                    return String(format: "%.0f", number)
                } else {
                    return String(format: "%.1f", number).replacingOccurrences(of: ".", with: ",")
                }
            }

            let sortedUniqueD1Array = Array(
                Set(TransitionModel.d1Array.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
            )
            .sorted()
            .map { number -> String in
                if number == number.rounded() {
                    return String(format: "%.0f", number)
                } else {
                    return String(format: "%.1f", number).replacingOccurrences(of: ".", with: ",")
                }
            }
            setupDropDownButton(buttonDropDown: dropDownSize, button: sizeButton, data: sortedUniqueDNArray) { selected in
                print(selected, "SSS")
                self.selectedSize = selected
            }
            setupDropDownButton(buttonDropDown: dropDownClass, button: classButton, data: sortedUniqueDArray) { selected in
                self.selectedClass = selected
            }
            setupDropDownButton(buttonDropDown: dropDownType, button: typeButton, data: sortedUniqueTArray) { selected in
                self.selectedType = selected
            }
            setupDropDownButton(buttonDropDown: dropDownParameter, button: parameterButton, data: sortedUniqueD1Array) { selected in
                self.selectedParameter = selected
            }
        default:
            let sortedUniqueDNArray = Array(
                Set(TransitionModel.dnArray2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
            )
            .sorted()
            .map { number -> String in
                if number == number.rounded() {
                    return String(format: "%.0f", number)
                } else {
                    return String(format: "%.1f", number).replacingOccurrences(of: ".", with: ",")
                }
            }

            let sortedUniqueDArray = Array(
                Set(TransitionModel.dArray2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
            )
            .sorted()
            .map { number -> String in
                if number == number.rounded() {
                    return String(format: "%.0f", number)
                } else {
                    return String(format: "%.1f", number).replacingOccurrences(of: ".", with: ",")
                }
            }

            let sortedUniqueTArray = Array(
                Set(TransitionModel.tArray2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
            )
            .sorted()
            .map { number -> String in
                if number == number.rounded() {
                    return String(format: "%.0f", number)
                } else {
                    return String(format: "%.1f", number).replacingOccurrences(of: ".", with: ",")
                }
            }

            let sortedUniqueD1Array = Array(
                Set(TransitionModel.d1Array2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
            )
            .sorted()
            .map { number -> String in
                if number == number.rounded() {
                    return String(format: "%.0f", number)
                } else {
                    return String(format: "%.1f", number).replacingOccurrences(of: ".", with: ",")
                }
            }
            setupDropDownButton(buttonDropDown: dropDownSize, button: sizeButton, data: sortedUniqueDNArray) { selected in
                self.selectedSize = selected
            }
            setupDropDownButton(buttonDropDown: dropDownClass, button: classButton, data: sortedUniqueDArray) { selected in
                self.selectedClass = selected
            }
            setupDropDownButton(buttonDropDown: dropDownType, button: typeButton, data: sortedUniqueTArray) { selected in
                self.selectedType = selected
            }
            setupDropDownButton(buttonDropDown: dropDownParameter, button: parameterButton, data: sortedUniqueD1Array) { selected in
                self.selectedParameter = selected
            }
        }

        setupDropDownButton(buttonDropDown: dropDownTitle, button: titleButton, data: TransitionModel.titlesArray) { selected in
            self.selectedTitle = selected
        }
        
        setupDropDownButton(buttonDropDown: dropDownVersion, button: versionButton, data: TransitionModel.versionArray) { selected in
            self.selectedVersion = selected
        }
    }

    func createFlangeConfigurations(
        version: [String],
        title: [String],
        dn: [String],
        d: [String],
        t: [String],
        d1: [String],
        t1: [String],
        l: [String],
        r: [String],
        r1: [String],
        mass: [String],
        imageName: [String],
        label1X: [CGFloat],
        label2X: [CGFloat],
        label3X: [CGFloat],
        label4X: [CGFloat],
        label5X: [CGFloat],
        label6X: [CGFloat],
        label7X: [CGFloat],
    
        label1Y: [CGFloat],
        label2Y: [CGFloat],
        label3Y: [CGFloat],
        label4Y: [CGFloat],
        label5Y: [CGFloat],
        label6Y: [CGFloat],
        label7Y: [CGFloat],
        flangesArray: [[[String]]]
    ) -> [FlangeConfiguration] {
        var configurations: [FlangeConfiguration] = []

        let count = min(dn.count, d.count, t.count, d1.count, t1.count, l.count, r.count, r1.count)

        for type in 0..<TransitionModel.titlesArray.count {
            for ver in 0..<TransitionModel.versionArray.count {
                for i in 0..<count {
                    let config = FlangeConfiguration(
                        version: version[ver],
                        title: title[type],
                        dn: flangesArray[ver][0][i],
                        d: flangesArray[ver][1][i],
                        t: flangesArray[ver][2][i],
                        d1: flangesArray[ver][5][i],
                        r: flangesArray[ver][3][i],
                        r1: flangesArray[ver][4][i],
                        mass: flangesArray[ver][8][i],
                        imageName: imageName[type],
                        label1Text: "D: \(flangesArray[ver][1][i])",
                        label2Text: "T: \(flangesArray[ver][2][i])",
                        label3Text: "R1: \(flangesArray[ver][3][i])",
                        label4Text: "R2: \(flangesArray[ver][4][i])",
                        label5Text: "T1: \(flangesArray[ver][6][i])",
                        label6Text: "D1: \(flangesArray[ver][5][i])",
                        label7Text: "L: \(flangesArray[ver][7][i])",
                        label1X: label1X[type],
                        label2X: label2X[type],
                        label3X: label3X[type],
                        label4X: label4X[type],
                        label5X: label5X[type],
                        label6X: label6X[type],
                        label7X: label7X[type],
                        label1Y: label1Y[type],
                        label2Y: label2Y[type],
                        label3Y: label3Y[type],
                        label4Y: label4Y[type],
                        label5Y: label5Y[type],
                        label6Y: label6Y[type],
                        label7Y: label7Y[type]
                    )
                    configurations.append(config)
                    print(config)
                }
            }
        }
        return configurations
    }

    @IBAction func versionButtonTapped(_ sender: UIButton) {dropDownVersion.show()}
    @IBAction func titleButtonTapped(_ sender: UIButton) {dropDownTitle.show()}
    @IBAction func sizeButtonTapped(_ sender: UIButton) {dropDownSize.show()}
    @IBAction func classButtonTapped(_ sender: UIButton) {dropDownClass.show()}
    @IBAction func typeButtonTapped(_ sender: UIButton) {dropDownType.show()}
    @IBAction func parameterButtonTapped(_ sender: UIButton) {dropDownParameter.show()}
}

extension TransitionViewController {
    func setupDropDownButton(buttonDropDown: DropDown, button: UIButton, data: [String], selectionHandler: @escaping (String) -> Void) {
        
        if button == titleButton {
            buttonDropDown.customCellConfiguration = { index, item, cell in
                
                cell.subviews.filter({ $0 is UIImageView }).forEach { $0.removeFromSuperview() }
                if let image = UIImage(named: TransitionModel.titlesImage[index]) {
                    let imageView = UIImageView(image: image)
                    imageView.tintColor = .systemGray
                    imageView.frame = CGRect(x: 10, y: 10, width: cell.frame.height - 20, height: cell.frame.height - 20)
                    if self.versionButton.titleLabel?.text == "Исполнение 1" {
                        cell.dopLabel.text = TransitionModel.dopsArray[0]
                    } else {
                        cell.dopLabel.text = TransitionModel.dopsArray[1]
                    }
                    cell.addSubview(imageView)
                }
            }
            buttonDropDown.selectionBackgroundColor = .clear
        }
        
        buttonDropDown.anchorView = button
        buttonDropDown.dataSource = data
        buttonDropDown.bottomOffset = CGPoint(x: 0, y: button.bounds.height)
        buttonDropDown.animationEntranceOptions = []
        buttonDropDown.animationExitOptions = []
        buttonDropDown.offsetFromWindowBottom = 15
        buttonDropDown.direction = .bottom
        buttonDropDown.width = button.frame.width
        
        if button == titleButton {
            buttonDropDown.cellHeight = button.frame.height * 2
        } else {
            buttonDropDown.cellHeight = button.frame.height
        }
        
        buttonDropDown.selectionAction = { (index: Int, item: String) in
            button.setTitle("\(item)", for: .normal)
            selectionHandler(item)
            self.selectedIndex = index
            self.findConfiguration()
        }
    }

    private func setupCoordinates(label: UILabel,x: CGFloat, y: CGFloat, text: String) {
        let screenSize = UIScreen.main.bounds.size
        let screenWidth = screenSize.width
        
        if imageView.subviews.contains(label) {
            label.removeFromSuperview()
        }
        
        label.text = text
        
        let fontSize = screenWidth * 0.045
        label.font = .customFont(name: "GOST type A Italic", size: fontSize)
        
        label.textColor = .black
        label.backgroundColor = .white
        //label.layer.borderColor = UIColor.red.cgColor
        //label.layer.borderWidth = 1
        label.sizeToFit()
        
        imageView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let relativeOffsetX = (x-7) / 402 * screenWidth
        let relativeOffsetY = y / 402 * screenWidth
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: relativeOffsetX),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: relativeOffsetY)
        ])
    }
    
    func setupBorder(labels: [UILabel], buttons: [UIButton]) {
        for button in buttons {
            button.layer.borderWidth = 0.3
            button.layer.borderColor = UIColor.black.cgColor
        }
        for label in labels {
            label.layer.borderWidth = 0.3
            label.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func setupTitles() {
        let defaultVersion = TransitionModel.versionArray[0]
        let defaultTitle = TransitionModel.titlesArray[0]
        let defaultSize = TransitionModel.dnArray[0]
        let defaultClass = TransitionModel.dArray[0]
        let defaultType = TransitionModel.tArray[0]
        let defaultParameter = TransitionModel.d1Array[0]
        
        versionButton.setTitle(defaultVersion, for: .normal)
        titleButton.setTitle(defaultTitle, for: .normal)
        sizeButton.setTitle(defaultSize, for: .normal)
        classButton.setTitle(defaultClass, for: .normal)
        typeButton.setTitle(defaultType, for: .normal)
        parameterButton.setTitle(defaultParameter, for: .normal)
        
        selectedVersion = defaultVersion
        selectedTitle = defaultTitle
        selectedSize = defaultSize
        selectedClass = defaultClass
        selectedType = defaultType
        selectedParameter = defaultParameter
        
        findConfiguration()
    }
    
    func updateDefaults() {
        let defaultSize = TransitionModel.dnArray2[0]
        let defaultClass = TransitionModel.dArray2[0]
        let defaultType = TransitionModel.tArray2[0]
        let defaultParameter = TransitionModel.d1Array2[0]
        
        sizeButton.titleLabel?.text = defaultSize
        classButton.titleLabel?.text = defaultClass
        typeButton.titleLabel?.text = defaultType
        parameterButton.titleLabel?.text = defaultParameter
        
        selectedSize = defaultSize
        selectedClass = defaultClass
        selectedType = defaultType
        selectedParameter = defaultParameter
        
        findConfiguration()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = screenTitle ?? "PipeInfo"
        navigationItem.backAction = UIAction { _ in
            self.navigationController?.popViewController(animated: false)
        }
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "square.and.arrow.down", withConfiguration: config)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
    }
    @objc private func doneButtonTapped() {
        let renderImage = containerView.asImage()
        saveImageToPhotosAlbum(renderImage, in: self)
    }
    
    func findConfiguration() {
        guard
            let version = selectedVersion,
            let title = selectedTitle,
            let dn = selectedSize,
            let d = selectedClass,
            let t = selectedType,
            let d1 = selectedParameter
        else { return }

        let key = "\(version)_\(title)_\(dn)_\(d)_\(t)_\(d1)"

        if let config = configurationDict[key] {
            imageView.image = UIImage(named: config.imageName)
            if config.title == "Переход концентрический" {
                schemeNameLabel.text = "Переход К-\(config.version.last ?? "1")- \(config.dn) x \(config.d) x \(config.t) x \(config.d1)"
            } else {
                schemeNameLabel.text = "Переход Э-\(config.version.last ?? "1")- \(config.dn) x \(config.d) x \(config.t) x \(config.d1)"
            }
            massLabel.text = "Масса \(config.mass) кг. "
            setupCoordinates(label: label1, x: config.label1X, y: config.label1Y, text: config.label1Text + " ")
            setupCoordinates(label: label2, x: config.label2X, y: config.label2Y, text: config.label2Text + " ")
            setupCoordinates(label: label3, x: config.label3X, y: config.label3Y, text: config.label3Text + " ")
            setupCoordinates(label: label4, x: config.label4X, y: config.label4Y, text: config.label4Text + " ")
            setupCoordinates(label: label5, x: config.label5X, y: config.label5Y, text: config.label5Text + " ")
            setupCoordinates(label: label6, x: config.label6X, y: config.label6Y, text: config.label6Text + " ")
            setupCoordinates(label: label7, x: config.label7X, y: config.label7Y, text: config.label7Text + " ")
        } else {
            imageView.image = nil
            schemeNameLabel.text = "Конфигурация не найдена"
            massLabel.text = "Попробуйте подобрать другие параметры "
            print("Конфигурация не найдена ", key)
            label1.text = ""
            label2.text = ""
            label3.text = ""
            label4.text = ""
            label5.text = ""
            label6.text = ""
            label7.text = ""
        }
    }

}
