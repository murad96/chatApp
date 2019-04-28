//
//  loginController+handlers.swift
//  chatApp
//
//  Created by Murad Al Wajed on 27/4/19.
//  Copyright © 2019 Murad Al Wajed. All rights reserved.
//

import UIKit
import Firebase
extension loginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func handleRegister(){
        print("tapping")
        guard let email = emailTextField.text,let password = passwordTextField.text, let name = nameTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            // ...
            guard let user = authResult?.user else { return }
            if error != nil {
                print(error)
                return
            }
            let uid = user.uid
            // Successfully Authenticated
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("\(imageName).png")
            if let uploadData = self.profileImageView.image!.pngData(){
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    /*let profileImageURL = metadata.downloadURL().absoluteString{
                        let values = ["name": name, "email": email, "profileImageURL": metadata.downloadURL]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                    }*/
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            return
                        }
                        if let profileImageUrl = url?.absoluteString {
                            let values = ["name": name, "email": email, "profileImageUrl": imageName]
                            self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        }
                    })
                    
                })
            }
        }
    }
    func registerUserIntoDatabaseWithUID(uid: String, values: [String: Any]){
        
        let ref = Database.database().reference()
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err)
                return
            }
            self.dismiss(animated: true, completion: nil)
        })
    }
    @objc func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage!
        if let originalImage = info[.originalImage] {
            selectedImageFromPicker = originalImage as? UIImage
        }else if let editedImage = info[.editedImage] {
            selectedImageFromPicker = editedImage as? UIImage
        }
        if let selectedImage = selectedImageFromPicker{
            profileImageView.image = selectedImage
        }
        dismiss(animated: false, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
}
