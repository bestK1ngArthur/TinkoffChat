//
//  ViewController.swift
//  Tinkoff Chat
//
//  Created by Artem Belkov on 20/09/2017.
//  Copyright © 2017 Artem Belkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userPhotoView: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var imagePicker = UIImagePickerController()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // print(editButton.frame)
        // fatal error: unexpectedly found nil while unwrapping an Optional value.
        // Потому что объект кнопки ещё но создан.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Артём Белков"
        descriptionLabel.text = "Люблю iOS 😍"
        
        print(editButton.frame)
        logMethod()
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
        
        // Prepare edit button
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 2
        editButton.layer.cornerRadius = 12
    }
    
    // MARK: Helpers
    
    func logMethod(_ method: String = #function) {
        print("ProfileViewController: \(method)")
    }
    
    // MARK: Actions
    
    @IBAction func editAction(_ sender: Any) {
        
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
}
