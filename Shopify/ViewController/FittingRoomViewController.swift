//
//  FittingRoomViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-18.
//

import UIKit

class FittingRoomViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate, StampSelectViewControllerDelegate, StampViewDelegate {
    
    @IBOutlet var stampBaseScrollView: StampScrollView!
    @IBOutlet var backgroundImageView: UIImageView!
    var focusedStamp: StampView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stampBaseScrollView.delegate = self
        stampBaseScrollView.minimumZoomScale = 1.0
        stampBaseScrollView.maximumZoomScale = 5.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let stampSelectVC = segue.destination as? StampSelectViewController {
            stampSelectVC.delegate = self
        }
    }
    
    @IBAction func cameraTapped(sender: UIButton) {
        showSourceSelection()
    }
    
    @IBAction func stampTapped(sender: UIButton) {
        performSegue(withIdentifier: "FittingRoomToStamp", sender: nil)
    }
    
    @IBAction func deleteTapped(sender: UIButton) {
        stampBaseScrollView.deleteStamp()
    }
    
    @IBAction func saveTapped(){
        confirmSave()
    }
    
    func pickImage(sourceType: UIImagePickerController.SourceType) {
        // check if the source is available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func showSourceSelection() {
        // create alert
        let alert = UIAlertController(title: "Select", message: "Please select outfits", preferredStyle: .alert)
        
        // alert options
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action: UIAlertAction!) in
            self.pickImage(sourceType: .camera)
        }
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (Action: UIAlertAction) in
            self.pickImage(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction) in
            print("Picker canceled")
        }
        
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    // delegate methods
    // This is executed when the image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //stampBaseScrollView.setBackgroundImage(image: pickedImage)
            backgroundImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func confirmSave() {
        let alert = UIAlertController(title: "Save Image", message: "Would you like to save the image?", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action: UIAlertAction!) in
            self.stampBaseScrollView.saveImageWithStamps()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction!) in
            print("Save canceled")
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // delegate method
    func didSelectStamp(stampImage: UIImage) {
        stampBaseScrollView.addStamp(stampImage: stampImage, fittingRoomViewController: self)
    }
    
    
    func didToucheStamp(stampView: StampView) {
        print("touched", stampView)
        self.focusedStamp = stampView
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("view for zooming", focusedStamp)
        return focusedStamp
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print("Zoom start")
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("Zoom end")
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("Did zoom")
    }

    
}
