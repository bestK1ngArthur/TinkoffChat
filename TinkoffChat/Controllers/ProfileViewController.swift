//
//  ViewController.swift
//  Tinkoff Chat
//
//  Created by Artem Belkov on 20/09/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private enum State {
        case show
        case edit
    }
    
    @IBOutlet weak var userPhotoView: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    
    // Show state
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    // Edit state
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var gcdButton: UIButton!
    @IBOutlet weak var operationButton: UIButton!
    
    private var imagePicker = UIImagePickerController()

    private var state: State = .show {
        didSet {
            self.updateState()
        }
    }
    private var user: User = User(name: "Артём Белков", description: "Люблю iOS 😍", imageName: "test")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // print(editButton.frame)
        // fatal error: unexpectedly found nil while unwrapping an Optional value.
        // Потому что объект кнопки ещё но создан.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .show
        
        titleLabel.text = user.name
        descriptionLabel.text = user.description
        
        print(editButton.frame)
        logMethod()
        
        // Load user
        GCDDataManager.shared.loadUser(success: { (user) in
            
            if let user = user {
                self.user = user
            }
            
            self.titleLabel.text = self.user.name
            self.descriptionLabel.text = self.user.description
            
        }) { (error) in
            // Error of loading user
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(editButton.frame)
        // Бадумс, фреймы одинаковые. Есть подозрение, что вся суть этого задания в том, чтобы сравнить фреймы до и после вызова layoutSubvies(). Однако, он вызывается после viewWillAppear(). Так что смотрите в viewDidAppear()
        logMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareUI()
        
        print(editButton.frame)
        // Вот, фреймы уже разные, так как был вызван метод layoutSubvies() и интерфейс подогнался по размер экрана.
        logMethod()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logMethod()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logMethod()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logMethod()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logMethod()
    }
    
    func prepareUI() {
        
        // Prepare user photo view
        userPhotoView.layer.cornerRadius = cameraView.frame.height / 2
        
        // Prepare camera view
        cameraView.layer.cornerRadius = cameraView.frame.height / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(changePhotoAction))
        cameraView.addGestureRecognizer(tap)
        
        // Prepare buttons
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 2
        editButton.layer.cornerRadius = 12
        gcdButton.layer.borderColor = UIColor.black.cgColor
        gcdButton.layer.borderWidth = 2
        gcdButton.layer.cornerRadius = 12
        operationButton.layer.borderColor = UIColor.black.cgColor
        operationButton.layer.borderWidth = 2
        operationButton.layer.cornerRadius = 12
    }
    
    func updateState() {
        switch state {
        case .show:
            
            // Set fields
            titleLabel.isHidden = false
            descriptionLabel.isHidden = false
            titleField.isHidden = true
            descriptionField.isHidden = true
            
            // Set imageView
            cameraView.isHidden = true
            
            // Set buttons
            editButton.isHidden = false
            gcdButton.isHidden = true
            operationButton.isHidden = true

            // Update labels
            titleLabel.text = user.name
            descriptionLabel.text = user.description
            
        case .edit:
            
            // Set fields
            titleLabel.isHidden = true
            descriptionLabel.isHidden = true
            titleField.isHidden = false
            descriptionField.isHidden = false
            
            // Set imageView
            cameraView.isHidden = false
            
            // Set buttons
            editButton.isHidden = true
            gcdButton.isHidden = false
            operationButton.isHidden = false

            // Update fields
            titleField.text = user.name
            descriptionField.text = user.description
        }
    }
    
    // MARK: Actions
    
    @IBAction func closeAction(_ sender: Any) {
        
        switch state {
        case .show:
            self.dismiss(animated: true, completion: nil)
        case .edit:
            self.state = .show
        }
    }
    
    @objc func changePhotoAction() {
        
        let alert = UIAlertController(title: "Выбери изображение профиля", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: UIAlertActionStyle.default) { action in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Галерея", style: UIAlertActionStyle.default) { action in
            self.openPhotoLibrary()
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        imagePicker.delegate = self
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editAction(_ sender: Any) {
        state = (state == .show) ? .edit : .show
    }
    
    @IBAction func gcdAction(_ sender: Any) {
        
        let newUser = User(name: titleField.text ?? "", description: descriptionField.text ?? "", imageName: "")
        GCDDataManager.shared.saveUser(newUser, success: {
            self.showAlert(title: "Данные сохранены", message: nil)
            self.state = .show
        }) { (error) in
            self.showAlert(title: "Ошибка", message: "Не удалось сохранить данные")
        }
    }
    
    @IBAction func operationAction(_ sender: Any) {
        
        let newUser = User(name: titleField.text ?? "", description: descriptionField.text ?? "", imageName: "")
        OperationDataManager.shared.saveUser(newUser, success: {
            self.showAlert(title: "Данные сохранены", message: nil)
            self.state = .show
        }) { (error) in
            self.showAlert(title: "Ошибка", message: "Не удалось сохранить данные")
        }
    }
    
    // MARK: Library & Camera
    
    func openCamera() {
        
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            present(imagePicker, animated: true, completion: nil)
        
        } else {
            
            let alertWarning = UIAlertController(title: "Упс..", message: "У тебя нет камеры", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertWarning.addAction(alertAction)
            present(alertWarning, animated: true, completion: nil)
        }
    }
    
    func openPhotoLibrary() {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: Image Picker Controller Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userPhotoView.image = image
        }
    }
    
    // MARK: Helpers
    
    func showAlert(title: String, message: String?) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                alertController.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func logMethod(_ method: String = #function) {
        print("ProfileViewController: \(method)")
    }
    
}
