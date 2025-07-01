// FlangeDrawingViewController.swift

import UIKit
import Photos

class TeeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageContainerView: UIView!
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
    let gostLabel = UILabel()
    
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
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.zoomScale = 1.0
        
        let configurations = createFlangeConfigurations(
            version: TeeModel.versionArray,
            title: TeeModel.titlesArray,
            dn: TeeModel.dnArray,
            d: TeeModel.dArray,
            t: TeeModel.tArray,
            d1: TeeModel.d1Array,
            t1: TeeModel.t1Array,
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
        findConfiguration()
        setupBorder(labels: dropDownLabels, buttons: dropDownButtons)
        firstUpdateDropDown()
        updateDropDowns()
    }
    
    
    func updateDropDowns() {
        switch versionButton.titleLabel?.text ?? "" {
        case "Исполнение 1 (ISO 3419)":
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
            
            setupDropDownButton(buttonDropDown: dropDownSize, button: sizeButton, data: sortedUniqueDNArray) { selected in
                self.selectedSize = selected

                guard let version = self.versionButton.titleLabel?.text else { return }

                let filtered = self.filterValues(forDN: selected, version: version)
                
                // CLASS (D)
                self.setupDropDownButton(buttonDropDown: self.dropDownClass, button: self.classButton, data: filtered.dValues) {
                    self.selectedClass = $0
                }
                if let firstD = filtered.dValues.first {
                    self.classButton.setTitle(firstD, for: .normal)
                    self.selectedClass = firstD
                }
                
                // TYPE (T)
                self.setupDropDownButton(buttonDropDown: self.dropDownType, button: self.typeButton, data: filtered.tValues) {
                    self.selectedType = $0
                }
                if let firstT = filtered.tValues.first {
                    self.typeButton.setTitle(firstT, for: .normal)
                    self.selectedType = firstT
                }
                
                // PARAMETER (D1)
                self.setupDropDownButton(buttonDropDown: self.dropDownParameter, button: self.parameterButton, data: filtered.d1Values) {
                    self.selectedParameter = $0
                }
                if let firstD1 = filtered.d1Values.first {
                    self.parameterButton.setTitle(firstD1, for: .normal)
                    self.selectedParameter = firstD1
                }
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

            setupDropDownButton(buttonDropDown: dropDownSize, button: sizeButton, data: sortedUniqueDNArray) { selected in
                self.selectedSize = selected

                guard let version = self.versionButton.titleLabel?.text else { return }

                let filtered = self.filterValues(forDN: selected, version: version)

                // CLASS (D)
                self.setupDropDownButton(buttonDropDown: self.dropDownClass, button: self.classButton, data: filtered.dValues) {
                    self.selectedClass = $0
                }
                if let firstD = filtered.dValues.first {
                    self.classButton.setTitle(firstD, for: .normal)
                    self.selectedClass = firstD
                }
                
                // TYPE (T)
                self.setupDropDownButton(buttonDropDown: self.dropDownType, button: self.typeButton, data: filtered.tValues) {
                    self.selectedType = $0
                }
                if let firstT = filtered.tValues.first {
                    self.typeButton.setTitle(firstT, for: .normal)
                    self.selectedType = firstT
                }
                
                // PARAMETER (D1)
                self.setupDropDownButton(buttonDropDown: self.dropDownParameter, button: self.parameterButton, data: filtered.d1Values) {
                    self.selectedParameter = $0
                }
                if let firstD1 = filtered.d1Values.first {
                    self.parameterButton.setTitle(firstD1, for: .normal)
                    self.selectedParameter = firstD1
                }
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
        print(count)
        print(dn.count, d.count, t.count, d1.count, t1.count, f.count, r.count, h.count, mass.count)
        
        let count2 = min(TeeModel.dnArray2.count, TeeModel.dArray2.count, TeeModel.tArray2.count, TeeModel.d1Array2.count, TeeModel.t1Array2.count, TeeModel.fArray2.count, TeeModel.rArray2.count, TeeModel.hArray2.count, TeeModel.massArray2.count)
//        print(count2)
//        print(TeeModel.dnArray2.count, TeeModel.dArray2.count, TeeModel.tArray2.count, TeeModel.d1Array2.count, TeeModel.t1Array2.count, TeeModel.fArray2.count, TeeModel.rArray2.count, TeeModel.hArray2.count, TeeModel.massArray2.count)
        
        let countArray = [count, count2]

        for type in 0..<TeeModel.titlesArray.count {
            for ver in 0..<TeeModel.versionArray.count {
                for i in 0..<countArray[ver] {
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
                    if self.versionButton.titleLabel?.text == "Исполнение 1 (ISO 3419)" {
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
            self.scrollView.zoomScale = 1.0
        }
    }

    private func setupCoordinates(label: UILabel,x: CGFloat, y: CGFloat, text: String) {
        let screenSize = UIScreen.main.bounds.size
        let screenWidth = screenSize.width
        
        if imageContainerView.subviews.contains(label) {
            label.removeFromSuperview()
        }
        
        if imageContainerView.subviews.contains(gostLabel) {
            gostLabel.removeFromSuperview()
        }
        
        label.text = text
        
        var fontSize = screenWidth * 0.035
        if label == label2 {
            fontSize = screenWidth * 0.030
        } else {
            fontSize = screenWidth * 0.035
        }
        label.font = .customFont(name: "GOST type A Italic", size: fontSize)
        
        label.textColor = .black
        label.backgroundColor = .white
        //label.layer.borderColor = UIColor.red.cgColor
        //label.layer.borderWidth = 1
        label.sizeToFit()
        
        imageContainerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let relativeOffsetX = (x-7) / 402 * screenWidth
        let relativeOffsetY = y / 402 * screenWidth
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor, constant: relativeOffsetX),
            label.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor, constant: relativeOffsetY)
        ])
        
        gostLabel.text = "ГОСТ 17376-2001 "
        gostLabel.font = .customFont(name: "GOST type A Italic", size: fontSize)
        gostLabel.sizeToFit()
        imageContainerView.addSubview(gostLabel)
        
        gostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gostLabel.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -8),
            gostLabel.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -8)
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
        
        let dowanloadConfig = UIImage.SymbolConfiguration(weight: .semibold)
        let sceneConfig = UIImage.SymbolConfiguration(weight: .medium)
        
        let downloadImage = UIImage(systemName: "arrow.down.square", withConfiguration: dowanloadConfig)
        let downloadButton = UIBarButtonItem(
            image: downloadImage,
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        let sceneImage = UIImage(systemName: "view.3d", withConfiguration: sceneConfig)
        let sceneButton = UIBarButtonItem(
            image: sceneImage,
            style: .plain,
            target: self,
            action: #selector(sceneButtonTapped)
        )

        navigationItem.rightBarButtonItems = [downloadButton, sceneButton]
    }
    
    @objc private func doneButtonTapped() {
        let renderImage = containerView.asImage()
        saveImageToPhotosAlbum(renderImage, in: self)
    }
    
    @objc private func sceneButtonTapped() {
        let sBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "SceneVC") as! SceneViewController
        vc.titleString = "3D - \(selectedTitle ?? "")"
        if titleButton.titleLabel?.text == "Равнопроходный" {
            vc.modelName = "eqModel.usdz"
        } else {
            vc.modelName = "noeqModel.usdz"
            vc.zCameraNodeMultiplier = 2.5
        }
        self.present(vc, animated: true)
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
                schemeNameLabel.text = "Тройник Р - \(config.dn) x \(config.d) x \(config.t) x \(config.d1)"
            } else {
                schemeNameLabel.text = "Тройник П - \(config.dn) x \(config.d) x \(config.t) x \(config.d1)"
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


extension TeeViewController {
    func filterValues(forDN dn: String, version: String) -> (dValues: [String], tValues: [String], d1Values: [String]) {
        let filtered = configurations.filter {
            $0.version == version && $0.dn == dn
        }

        let dValues = Array(Set(filtered.map { $0.d })).sorted(by: { $0.toDouble < $1.toDouble })
        let tValues = Array(Set(filtered.map { $0.t })).sorted(by: { $0.toDouble < $1.toDouble })
        let d1Values = Array(Set(filtered.map { $0.d1 })).sorted(by: { $0.toDouble < $1.toDouble })

        return (dValues, tValues, d1Values)
    }
    
    private func firstUpdateDropDown() {
        switch versionButton.titleLabel?.text ?? "" {
        case "Исполнение 1 (ISO 3419)":
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
            setupDropDownButton(buttonDropDown: dropDownSize, button: sizeButton, data: sortedUniqueDNArray) { selected in
                    self.selectedSize = selected
                    
                    guard let version = self.versionButton.titleLabel?.text else { return }
                    
                    let filtered = self.filterValues(forDN: selected, version: version)
                    
                    self.setupDropDownButton(buttonDropDown: self.dropDownClass, button: self.classButton, data: filtered.dValues) {
                        self.selectedClass = $0
                    }
                    self.setupDropDownButton(buttonDropDown: self.dropDownType, button: self.typeButton, data: filtered.tValues) {
                        self.selectedType = $0
                    }
                    self.setupDropDownButton(buttonDropDown: self.dropDownParameter, button: self.parameterButton, data: filtered.d1Values) {
                        self.selectedParameter = $0
                    }
                }

                if let currentDN = sizeButton.titleLabel?.text,
                   let version = versionButton.titleLabel?.text {
                    
                    let filtered = filterValues(forDN: currentDN, version: version)
                    
                    setupDropDownButton(buttonDropDown: dropDownClass, button: classButton, data: filtered.dValues) {
                        self.selectedClass = $0
                    }
                    setupDropDownButton(buttonDropDown: dropDownType, button: typeButton, data: filtered.tValues) {
                        self.selectedType = $0
                    }
                    setupDropDownButton(buttonDropDown: dropDownParameter, button: parameterButton, data: filtered.d1Values) {
                        self.selectedParameter = $0
                    }
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
            setupDropDownButton(buttonDropDown: dropDownSize, button: sizeButton, data: sortedUniqueDNArray) { selected in
                    self.selectedSize = selected
                    
                    guard let version = self.versionButton.titleLabel?.text else { return }
                    
                    let filtered = self.filterValues(forDN: selected, version: version)
                    
                    self.setupDropDownButton(buttonDropDown: self.dropDownClass, button: self.classButton, data: filtered.dValues) {
                        self.selectedClass = $0
                    }
                    self.setupDropDownButton(buttonDropDown: self.dropDownType, button: self.typeButton, data: filtered.tValues) {
                        self.selectedType = $0
                    }
                    self.setupDropDownButton(buttonDropDown: self.dropDownParameter, button: self.parameterButton, data: filtered.d1Values) {
                        self.selectedParameter = $0
                    }
                }

                // ⬇️ Автоматическая фильтрация по текущему значению sizeButton (если есть)
                if let currentDN = sizeButton.titleLabel?.text,
                   let version = versionButton.titleLabel?.text {
                    
                    let filtered = filterValues(forDN: currentDN, version: version)
                    
                    setupDropDownButton(buttonDropDown: dropDownClass, button: classButton, data: filtered.dValues) {
                        self.selectedClass = $0
                    }
                    setupDropDownButton(buttonDropDown: dropDownType, button: typeButton, data: filtered.tValues) {
                        self.selectedType = $0
                    }
                    setupDropDownButton(buttonDropDown: dropDownParameter, button: parameterButton, data: filtered.d1Values) {
                        self.selectedParameter = $0
                    }
                }
        }
    }
}

extension TeeViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageContainerView
    }
}
