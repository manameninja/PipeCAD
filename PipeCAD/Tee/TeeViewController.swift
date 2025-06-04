// FlangeDrawingViewController.swift

import UIKit
import Photos

class TeeViewController: UIViewController {
    
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
    
    var configurationDict: [String: TeeConfiguration] = [:]
    var configurations: [TeeConfiguration] = []
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    let label8 = UILabel()
    let label9 = UILabel()
    
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
            version: TeeModel.versionArray,
            title: TeeModel.titlesArray,
            dn: TeeModel.dnArray,
            d: TeeModel.dArray,
            t: TeeModel.tArray,
            d1: TeeModel.d1Array,
            t1: TeeModel.t1Array2,
            f: TeeModel.fArray,
            h: TeeModel.hArray,
            r: TeeModel.rArray,
            mass: TeeModel.massArray,
            imageName: TeeModel.titlesImage,
            label1X: TeeModel.label1XArray,
            label2X: TeeModel.label2XArray,
            label3X: TeeModel.label3XArray,
            label4X: TeeModel.label4XArray,
            label5X: TeeModel.label5XArray,
            label6X: TeeModel.label6XArray,
            label7X: TeeModel.label7XArray,
            label8X: TeeModel.label8XArray,
            label9X: TeeModel.label9XArray,
            label1Y: TeeModel.label1YArray,
            label2Y: TeeModel.label2YArray,
            label3Y: TeeModel.label3YArray,
            label4Y: TeeModel.label4YArray,
            label5Y: TeeModel.label5YArray,
            label6Y: TeeModel.label6YArray,
            label7Y: TeeModel.label7YArray,
            label8Y: TeeModel.label8YArray,
            label9Y: TeeModel.label9YArray,
            flangesArray: TeeModel.flangesArray
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
                Set(TeeModel.dnArray.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                Set(TeeModel.dArray.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                Set(TeeModel.tArray.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                Set(TeeModel.d1Array.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                Set(TeeModel.dnArray2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                Set(TeeModel.dArray2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                Set(TeeModel.tArray2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                Set(TeeModel.d1Array2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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

        setupDropDownButton(buttonDropDown: dropDownTitle, button: titleButton, data: TeeModel.titlesArray) { selected in
            self.selectedTitle = selected
        }
        
        setupDropDownButton(buttonDropDown: dropDownVersion, button: versionButton, data: TeeModel.versionArray) { selected in
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
        f: [String],
        h: [String],
        r: [String],
        mass: [String],
        imageName: [String],
        label1X: [CGFloat],
        label2X: [CGFloat],
        label3X: [CGFloat],
        label4X: [CGFloat],
        label5X: [CGFloat],
        label6X: [CGFloat],
        label7X: [CGFloat],
        label8X: [CGFloat],
        label9X: [CGFloat],
    
        label1Y: [CGFloat],
        label2Y: [CGFloat],
        label3Y: [CGFloat],
        label4Y: [CGFloat],
        label5Y: [CGFloat],
        label6Y: [CGFloat],
        label7Y: [CGFloat],
        label8Y: [CGFloat],
        label9Y: [CGFloat],
        flangesArray: [[[String]]]
    ) -> [TeeConfiguration] {
        var configurations: [TeeConfiguration] = []

        let count = min(dn.count, d.count, t.count, d1.count, t1.count, f.count, r.count, h.count, mass.count)

        for type in 0..<TeeModel.titlesArray.count {
            for ver in 0..<TeeModel.versionArray.count {
                for i in 0..<count {
                    print(count)
                    print(t1.count)
                    let config = TeeConfiguration(
                        version: version[ver],
                        title: title[type],
                        dn: flangesArray[ver][7][i],
                        d: flangesArray[ver][2][i],
                        t: flangesArray[ver][3][i],
                        d1: flangesArray[ver][5][i],
                        t1: flangesArray[ver][4][i],
                        f: flangesArray[ver][6][i],
                        h: flangesArray[ver][0][i],
                        r: flangesArray[ver][1][i],
                        mass: flangesArray[ver][8][i],
                        imageName: imageName[type],
                        label1Text: "H: \(flangesArray[ver][0][i])",
                        label2Text: "R: \(flangesArray[ver][1][i])",
                        label3Text: "D: \(flangesArray[ver][2][i])",
                        label4Text: "T: \(flangesArray[ver][3][i])",
                        label5Text: "T1: \(flangesArray[ver][4][i])",
                        label6Text: "D: \(flangesArray[ver][2][i])",
                        label7Text: "T: \(flangesArray[ver][3][i])",
                        label8Text: "F: \(flangesArray[ver][6][i])",
                        label9Text: "F: \(flangesArray[ver][6][i])",
                        label1X: label1X[type],
                        label2X: label2X[type],
                        label3X: label3X[type],
                        label4X: label4X[type],
                        label5X: label5X[type],
                        label6X: label6X[type],
                        label7X: label7X[type],
                        label8X: label8X[type],
                        label9X: label9X[type],
                        label1Y: label1Y[type],
                        label2Y: label2Y[type],
                        label3Y: label3Y[type],
                        label4Y: label4Y[type],
                        label5Y: label5Y[type],
                        label6Y: label6Y[type],
                        label7Y: label7Y[type],
                        label8Y: label8Y[type],
                        label9Y: label9Y[type],
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

extension TeeViewController {
    func setupDropDownButton(buttonDropDown: DropDown, button: UIButton, data: [String], selectionHandler: @escaping (String) -> Void) {
        
        if button == titleButton {
            buttonDropDown.customCellConfiguration = { index, item, cell in
                
                cell.subviews.filter({ $0 is UIImageView }).forEach { $0.removeFromSuperview() }
                if let image = UIImage(named: TeeModel.titlesImage[index]) {
                    let imageView = UIImageView(image: image)
                    imageView.tintColor = .systemGray
                    imageView.frame = CGRect(x: 10, y: 10, width: cell.frame.height - 20, height: cell.frame.height - 20)
                    if self.versionButton.titleLabel?.text == "Исполнение 1" {
                        cell.dopLabel.text = TeeModel.dopsArray[0]
                    } else {
                        cell.dopLabel.text = TeeModel.dopsArray[1]
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
        
        let fontSize = screenWidth * 0.04
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
        let defaultVersion = TeeModel.versionArray[0]
        let defaultTitle = TeeModel.titlesArray[0]
        let defaultSize = TeeModel.dnArray[0]
        let defaultClass = TeeModel.dArray[0]
        let defaultType = TeeModel.tArray[0]
        let defaultParameter = TeeModel.d1Array[0]
        
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
        let defaultSize = TeeModel.dnArray2[0]
        let defaultClass = TeeModel.dArray2[0]
        let defaultType = TeeModel.tArray2[0]
        let defaultParameter = TeeModel.d1Array2[0]
        
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
            if config.title == "Равнопроходный" {
                schemeNameLabel.text = "Переход Р-\(config.version.last ?? "1")- \(config.dn) x \(config.d) x \(config.t) x \(config.d1)"
            } else {
                schemeNameLabel.text = "Переход П-\(config.version.last ?? "1")- \(config.dn) x \(config.d) x \(config.t) x \(config.d1)"
            }
            massLabel.text = "Масса \(config.mass) кг. "
            setupCoordinates(label: label1, x: config.label1X, y: config.label1Y, text: config.label1Text + " ")
            setupCoordinates(label: label2, x: config.label2X, y: config.label2Y, text: config.label2Text + " ")
            setupCoordinates(label: label3, x: config.label3X, y: config.label3Y, text: config.label3Text + " ")
            setupCoordinates(label: label4, x: config.label4X, y: config.label4Y, text: config.label4Text + " ")
            setupCoordinates(label: label5, x: config.label5X, y: config.label5Y, text: config.label5Text + " ")
            setupCoordinates(label: label6, x: config.label6X, y: config.label6Y, text: config.label6Text + " ")
            setupCoordinates(label: label7, x: config.label7X, y: config.label7Y, text: config.label7Text + " ")
            setupCoordinates(label: label8, x: config.label8X, y: config.label8Y, text: config.label8Text + " ")
            setupCoordinates(label: label9, x: config.label9X, y: config.label9Y, text: config.label9Text + " ")
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
            label8.text = ""
            label9.text = ""
        }
    }
}
