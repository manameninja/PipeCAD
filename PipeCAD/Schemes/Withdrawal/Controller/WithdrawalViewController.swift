// FlangeDrawingViewController.swift

import UIKit
import Photos

class WithdrawalViewController: UIViewController {
    
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
    @IBOutlet weak var stackView4: UIStackView!
    
    var screenTitle: String?
    var selectedIndex: Int?
    
    var selectedVersion: String?
    var selectedTitle: String?
    var selectedSize: String?
    var selectedClass: String?
    var selectedType: String?
    var selectedParameter: String?
    
    var configurationDict: [String: WithdrawalConfiguration] = [:]
    var configurations: [WithdrawalConfiguration] = []
    
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
            version: WithdrawalModel.versionArray,
            title: WithdrawalModel.titlesArrayArray,
            dn: WithdrawalModel.dnArray,
            d: WithdrawalModel.dArray,
            t: WithdrawalModel.tArray,
            r: WithdrawalModel.rArray,
            h: WithdrawalModel.hArray,
            c: WithdrawalModel.cArray,
            b: WithdrawalModel.bArray,
            mass45: WithdrawalModel.massArray45,
            mass60: WithdrawalModel.massArray60_2,
            mass90: WithdrawalModel.massArray90,
            mass180: WithdrawalModel.massArray180,
            imageName: WithdrawalModel.titlesImageArray,
            label1X: WithdrawalModel.label1xArrayArray,
            label2X: WithdrawalModel.label2xArrayArray,
            label3X: WithdrawalModel.label3xArrayArray,
            label4X: WithdrawalModel.label4xArrayArray,
            label5X: WithdrawalModel.label5xArrayArray,
            label6X: WithdrawalModel.label6xArrayArray,
            label7X: WithdrawalModel.label7xArrayArray,
            label8X: WithdrawalModel.label8xArrayArray,
            label9X: WithdrawalModel.label9xArrayArray,
            label1Y: WithdrawalModel.label1yArrayArray,
            label2Y: WithdrawalModel.label2yArrayArray,
            label3Y: WithdrawalModel.label3yArrayArray,
            label4Y: WithdrawalModel.label4yArrayArray,
            label5Y: WithdrawalModel.label5yArrayArray,
            label6Y: WithdrawalModel.label6yArrayArray,
            label7Y: WithdrawalModel.label7yArrayArray,
            label8Y: WithdrawalModel.label8yArrayArray,
            label9Y: WithdrawalModel.label9yArrayArray,
            flangesArray: WithdrawalModel.flangesArray)
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
                Set(WithdrawalModel.dnArray.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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

                // CLASS (T)
                self.setupDropDownButton(buttonDropDown: self.dropDownClass, button: self.classButton, data: filtered) {
                    self.selectedClass = $0
                }
                if let firstT = filtered.first {
                    self.classButton.setTitle(firstT, for: .normal)
                    self.selectedClass = firstT
                }
            }

        default:
            let sortedUniqueDNArray = Array(
                Set(WithdrawalModel.dnArray2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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

                self.setupDropDownButton(buttonDropDown: self.dropDownClass, button: self.classButton, data: filtered) {
                    self.selectedClass = $0
                }
                
                if let firstT = filtered.first {
                    self.classButton.setTitle(firstT, for: .normal)
                    self.selectedClass = firstT
                }
                
            }
        }

        if versionButton.titleLabel?.text == "Исполнение 1 (ISO 3419)" {
            setupDropDownButton(buttonDropDown: dropDownTitle, button: titleButton, data: WithdrawalModel.titlesArrayArray[0]) { selected in
                self.selectedTitle = selected
            }
        } else {
            setupDropDownButton(buttonDropDown: dropDownTitle, button: titleButton, data: WithdrawalModel.titlesArrayArray[1]) { selected in
                self.selectedTitle = selected
            }
        }
        
        setupDropDownButton(buttonDropDown: dropDownVersion, button: versionButton, data: WithdrawalModel.versionArray) { selected in
            self.selectedVersion = selected
        }
    }

    func createFlangeConfigurations(
        version: [String],
        title: [[String]],
        dn: [String],
        d: [String],
        t: [String],
        r: [String],
        h: [String],
        c: [String],
        b: [String],
        mass45: [String],
        mass60: [String],
        mass90: [String],
        mass180: [String],
        imageName: [[String]],
        label1X: [[CGFloat]],
        label2X: [[CGFloat]],
        label3X: [[CGFloat]],
        label4X: [[CGFloat]],
        label5X: [[CGFloat]],
        label6X: [[CGFloat]],
        label7X: [[CGFloat]],
        label8X: [[CGFloat]],
        label9X: [[CGFloat]],
    
        label1Y: [[CGFloat]],
        label2Y: [[CGFloat]],
        label3Y: [[CGFloat]],
        label4Y: [[CGFloat]],
        label5Y: [[CGFloat]],
        label6Y: [[CGFloat]],
        label7Y: [[CGFloat]],
        label8Y: [[CGFloat]],
        label9Y: [[CGFloat]],
        flangesArray: [[[String]]]
    ) -> [WithdrawalConfiguration] {
        var configurations: [WithdrawalConfiguration] = []

        let count = min(dn.count, d.count, t.count, r.count, h.count, c.count, b.count, mass45.count, mass60.count, mass90.count, mass180.count)
//        print(dn.count, d.count, t.count, d1.count, t1.count, l.count, r.count, r1.count)
//        print(TransitionModel.dnArray.count, TransitionModel.dArray.count, TransitionModel.tArray.count, TransitionModel.d1Array.count, TransitionModel.t1Array.count, TransitionModel.lArray.count, TransitionModel.rArray.count, TransitionModel.r1Array.count)
        
        let count2 = min(WithdrawalModel.dnArray2.count, WithdrawalModel.dArray2.count, WithdrawalModel.tArray2.count, WithdrawalModel.rArray2.count, WithdrawalModel.hArray2.count, WithdrawalModel.cArray2.count, WithdrawalModel.bArray2.count, WithdrawalModel.massArray45_2.count, WithdrawalModel.massArray60_2.count, WithdrawalModel.massArray90_2.count, WithdrawalModel.massArray180_2.count)
//        print(count2)
//        print(TransitionModel.dnArray2.count, TransitionModel.dArray2.count, TransitionModel.tArray2.count, TransitionModel.d1Array2.count, TransitionModel.t1Array2.count, TransitionModel.lArray2.count, TransitionModel.rArray2.count, TransitionModel.r1Array2.count)
        
        let countArray = [count, count2]
        for ver in 0..<WithdrawalModel.versionArray.count {
            for type in 0..<WithdrawalModel.titlesArrayArray[ver].count {
                for i in 0..<countArray[ver] {
                    let config = WithdrawalConfiguration(
                        version: version[ver],
                        title: title[ver][type],
                        dn: flangesArray[ver][0][i],
                        d: flangesArray[ver][1][i],
                        t: flangesArray[ver][2][i],
                        r: flangesArray[ver][3][i],
                        w: flangesArray[ver][4][i],
                        h: flangesArray[ver][5][i],
                        c: flangesArray[ver][6][i],
                        b: flangesArray[ver][7][i],
                        mass45: flangesArray[ver][8][i],
                        mass60: flangesArray[ver][9][i],
                        mass90: flangesArray[ver][10][i],
                        mass180: flangesArray[ver][11][i],
                        imageName: imageName[ver][type],
                        label1Text: "D: \(flangesArray[ver][1][i])",
                        label2Text: "T: \(flangesArray[ver][2][i])",
                        label3Text: "R: \(flangesArray[ver][3][i])",
                        label4Text: "W: \(flangesArray[ver][4][i])",
                        label5Text: "T: \(flangesArray[ver][2][i])",
                        label6Text: "H: \(flangesArray[ver][5][i])",
                        label7Text: "B: \(flangesArray[ver][7][i])",
                        label8Text: "F: \(flangesArray[ver][3][i])",
                        label9Text: "C: \(flangesArray[ver][6][i])",
                        label1X: label1X[ver][type],
                        label2X: label2X[ver][type],
                        label3X: label3X[ver][type],
                        label4X: label4X[ver][type],
                        label5X: label5X[ver][type],
                        label6X: label6X[ver][type],
                        label7X: label7X[ver][type],
                        label8X: label8X[ver][type],
                        label9X: label9X[ver][type],
                        label1Y: label1Y[ver][type],
                        label2Y: label2Y[ver][type],
                        label3Y: label3Y[ver][type],
                        label4Y: label4Y[ver][type],
                        label5Y: label5Y[ver][type],
                        label6Y: label6Y[ver][type],
                        label7Y: label7Y[ver][type],
                        label8Y: label8Y[ver][type],
                        label9Y: label9Y[ver][type]
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
}

extension WithdrawalViewController {
    func setupDropDownButton(buttonDropDown: DropDown, button: UIButton, data: [String], selectionHandler: @escaping (String) -> Void) {
        
        if button == titleButton {
            buttonDropDown.customCellConfiguration = { index, item, cell in
                
                cell.subviews.filter({ $0 is UIImageView }).forEach { $0.removeFromSuperview() }
                if let image = UIImage(named: WithdrawalModel.titlesImage2[index]) {
                    let imageView = UIImageView(image: image)
                    imageView.tintColor = .systemGray
                    imageView.frame = CGRect(x: 10, y: 10, width: cell.frame.height - 20, height: cell.frame.height - 20)
                    if self.versionButton.titleLabel?.text == "Исполнение 1 (ISO 3419)" {
                        cell.dopLabel.text = WithdrawalModel.dopsArray[0]
                    } else {
                        cell.dopLabel.text = WithdrawalModel.dopsArray[1]
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
            self.scrollView.zoomScale = 1.0
            self.findConfiguration()
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
        
        if label == label6 {
            label.transform = CGAffineTransform(rotationAngle: -.pi / 3.7)
        }
        
        if label == label5 && selectedTitle == "Отвод 45 градусов" {
            label.transform = CGAffineTransform(rotationAngle: .pi / 18)
        } else if label == label5 {
            label.transform = CGAffineTransform(rotationAngle: .pi * 2 / 1)
        }
        
        if label == label4 && selectedTitle == "Отвод 60 градусов" {
            label.transform = CGAffineTransform(rotationAngle: -.pi / 5.5)
        } else if label == label4 {
            label.transform = CGAffineTransform(rotationAngle: .pi * 2 / 1)
        }
        
        if label == label3 && selectedTitle == "Отвод 180 градусов" {
            label.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        } else if label == label3 {
            label.transform = CGAffineTransform(rotationAngle: .pi * 2 / 1)
        }
        
        var fontSize = screenWidth * 0.035
        
        if label == label5 && selectedTitle == "Отвод 90 градусов" {
            fontSize = screenWidth * 0.030
        } else if label == label1 && selectedTitle == "Отвод 180 градусов" {
            fontSize = screenWidth * 0.040
        } else {
            fontSize = screenWidth * 0.035
        }
        
        label.font = .customFont(name: "GOST type A Italic", size: fontSize)
        
        label.textColor = .black
        label.backgroundColor = .white
        //label.layer.borderColor = UIColor.red.cgColor
        //label.layer.borderWidth = 1
        label.sizeToFit()
        
        //imageView.addSubview(label)
        imageContainerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let relativeOffsetX = (x-7) / 402 * screenWidth
        let relativeOffsetY = y / 402 * screenWidth
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor, constant: relativeOffsetX),
            label.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor, constant: relativeOffsetY)
        ])
        
        gostLabel.text = "ГОСТ 17375-71 "
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
        let defaultVersion = WithdrawalModel.versionArray[0]
        let defaultTitle = WithdrawalModel.titlesArray[0]
        let defaultSize = WithdrawalModel.dnArray[0]
        let defaultClass = WithdrawalModel.tArray[0]
        
        versionButton.setTitle(defaultVersion, for: .normal)
        titleButton.setTitle(defaultTitle, for: .normal)
        sizeButton.setTitle(defaultSize, for: .normal)
        classButton.setTitle(defaultClass, for: .normal)
        
        selectedVersion = defaultVersion
        selectedTitle = defaultTitle
        selectedSize = defaultSize
        selectedClass = defaultClass
        
        findConfiguration()
    }
    
    func updateDefaults() {
        let defaultSize = WithdrawalModel.dnArray2[0]
        let defaultClass = WithdrawalModel.tArray2[0]
        
        sizeButton.titleLabel?.text = defaultSize
        classButton.titleLabel?.text = defaultClass
        
        selectedSize = defaultSize
        selectedClass = defaultClass
        
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
        
        switch titleButton.titleLabel?.text {
        case "Отвод 45 градусов": vc.modelName = "wd45model.usdz"
        case "Отвод 60 градусов": vc.modelName = "wd60model.usdz"
        case "Отвод 90 градусов": vc.modelName = "wd90model.usdz"
        case "Отвод 180 градусов": vc.modelName = "wd180model.usdz"
        default: vc.modelName = "wd45model.usdz"
        }
        
        self.present(vc, animated: true)
    }
    
    func findConfiguration() {
        guard
            let version = selectedVersion,
            let title = selectedTitle,
            let dn = selectedSize,
            let t = selectedClass
        else { return }

        let key = "\(version)_\(title)_\(dn)_\(t)"

        if let config = configurationDict[key] {
            imageView.image = UIImage(named: config.imageName)
            if config.version == "Исполнение 1 (ISO 3419)" {
                schemeNameLabel.text = "\(config.title) - 1 - \(config.dn) x \(config.t) ГОСТ 17375-71"
            } else {
                schemeNameLabel.text = "\(config.title) - 2 - \(config.dn) x \(config.t) ГОСТ 17375-71"
            }
            switch config.title {
            case "Отвод 45 градусов":
                massLabel.text = "Масса \(config.mass45) кг. "
            case "Отвод 60 градусов":
                if config.version == "Исполнение 1 (ISO 3419)" {
                    massLabel.text = "Масса \(config.mass90) кг. "
                } else {
                    massLabel.text = "Масса \(config.mass60) кг. "
                }
            case "Отвод 90 градусов":
                if config.version == "Исполнение 1 (ISO 3419)" {
                    massLabel.text = "Масса \(config.mass60) кг. "
                } else {
                    massLabel.text = "Масса \(config.mass90) кг. "
                }
            case "Отвод 180 градусов":
                massLabel.text = "Масса \(config.mass180) кг. "
            default:
                massLabel.text = "Масса  кг. "
            }
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
            gostLabel.text = ""
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

extension WithdrawalViewController {
    func filterValues(forDN dn: String, version: String) -> ([String]) {
        let filtered = configurations.filter {
            $0.version == version && $0.dn == dn
        }

        let tValues = Array(Set(filtered.map { $0.t })).sorted(by: { $0.toDouble < $1.toDouble })

        return (tValues)
    }
    
    private func firstUpdateDropDown() {
        switch versionButton.titleLabel?.text ?? "" {
        case "Исполнение 1 (ISO 3419)":
            let sortedUniqueDNArray = Array(
                Set(WithdrawalModel.dnArray.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                    
                    self.setupDropDownButton(buttonDropDown: self.dropDownClass, button: self.classButton, data: filtered) {
                        self.selectedClass = $0
                    }
                }

                if let currentDN = sizeButton.titleLabel?.text,
                   let version = versionButton.titleLabel?.text {
                    
                    let filtered = filterValues(forDN: currentDN, version: version)
                    
                    setupDropDownButton(buttonDropDown: dropDownClass, button: classButton, data: filtered) {
                        self.selectedClass = $0
                    }
                }
        default:
            let sortedUniqueDNArray = Array(
                Set(WithdrawalModel.dnArray2.compactMap { Double($0.replacingOccurrences(of: ",", with: ".")) })
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
                    
                    self.setupDropDownButton(buttonDropDown: self.dropDownClass, button: self.classButton, data: filtered) {
                        self.selectedClass = $0
                    }
                }

                // ⬇️ Автоматическая фильтрация по текущему значению sizeButton (если есть)
                if let currentDN = sizeButton.titleLabel?.text,
                   let version = versionButton.titleLabel?.text {
                    
                    let filtered = filterValues(forDN: currentDN, version: version)
                    
                    setupDropDownButton(buttonDropDown: dropDownClass, button: classButton, data: filtered) {
                        self.selectedClass = $0
                    }
                }
        }
    }
}

extension WithdrawalViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageContainerView
    }
}
