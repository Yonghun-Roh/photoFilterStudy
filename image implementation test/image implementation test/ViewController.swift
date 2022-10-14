//
//  ViewController.swift
//  image implementation test
//
//  Created by Yonghun Roh on 2022/10/14.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, SHViewControllerDelegate {
    
    
    
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPhotoAlbum(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        self.present(picker, animated: false)
    }
    @IBAction func filterBTNPressed(_ sender: Any) {
        let sharakuController = SHViewController(image: imgView.image!)
        sharakuController.delegate = self
        self.present(sharakuController, animated: true)
    }
    func shViewControllerImageDidFilter(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer) {
        print("save finished!")
    }
    
    func shViewControllerDidCancel() {
        //
    }
}
extension ViewController: UIImagePickerControllerDelegate {
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("이미지 선택하지않고 취소한 경우")
            self.dismiss(animated: false) { () in
                let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                self.present(alert, animated: false)
                
            }
        }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("이미지 선택")
        picker.dismiss(animated: false) { () in
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imgView.image = img
        }
     
    }
    
}

