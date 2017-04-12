//
//  ViewController.swift
//  Multimedia en iOS
//
//  Created by alumno on 4/11/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    var player:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func btnCambiarTouch(_ sender: UIButton) {
        
        
        var alertController:UIAlertController
        alertController = UIAlertController(title: "Seleccione una opcion", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let camara  = UIAlertAction(title: "Camara", style: UIAlertActionStyle.default, handler: { (action) in
            print("Camara")
            self.usarCamara()
        })
        
        let galeriaFotos  = UIAlertAction(title: "Galeria de Fotos", style: UIAlertActionStyle.default, handler: { (action) in
            print("Galeria de Fotos")
            self.usarGaleria()
            
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: { (action) in
            print("Cancelar")
        })
        
        alertController.addAction(camara)
        alertController.addAction(galeriaFotos)
        alertController.addAction(cancelar)
        self.present(alertController, animated: true, completion: {
            
        })
        
    }
    
    @IBAction func btnReproducirTouch(_ sender: UIButton) {
        
        let path = Bundle.main.path(forResource: "sonido.wav", ofType: nil)
        
        let url = URL(fileURLWithPath: path!)

        do {
            
            let sonido = try AVAudioPlayer(contentsOf: url)

            player = sonido
            player?.numberOfLoops = -1
            player?.play()
            if  (player?.isPlaying)!{
                
                player?.play()
            }

        } catch {
            
            print("error !!!!")
            
        }
        
        
        
    }
    
    @IBAction func btnDetenertouch(_ sender: UIButton) {
        
        if player != nil {
            player?.stop()
            player = nil
        }
    }
    
    
    @IBAction func btnMostrarVideoTouch(_ sender: UIButton) {
        
        let path = Bundle.main.path(forResource: "small.mp4", ofType: nil)
        
        let url = URL(fileURLWithPath: path!)
        
        let videoPlayer = AVPlayer(url: url)
        
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = videoPlayer
        
        playerViewController.player?.play()
        
        self.present(playerViewController, animated: true) {}
        
        
        
    }
    
    func usarCamara(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            
            self.present(imagePicker, animated: true, completion: {})
            
        }
        
    }
    
    func usarGaleria(){
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.present(imagePicker, animated: true, completion: {})
        }
        
    }
    
    //metodos
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imageGet = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = imageGet
        
        self.dismiss(animated: true){}
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true){}
    }

}

