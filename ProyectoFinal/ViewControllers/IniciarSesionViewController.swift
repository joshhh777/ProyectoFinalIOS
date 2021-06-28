//
//  ViewController.swift
//  ProyectoFinal
//
//  Created by Mac 09 on 6/21/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var TextContraseña: UITextField!
    @IBOutlet weak var TextUsuario: UITextField!
    
    
    
    @IBAction func iniciarSesion(_ sender: Any) {
        Auth.auth().signIn(withEmail: TextUsuario.text!, password: TextContraseña.text!) {
            (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil{
                let alerta = UIAlertController(title: "Usuario no Existe", message: "Usuario: \(self.TextUsuario.text!) no se encuentra Registrado", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Crear", style: .default, handler: {(UIAlertAction) in
                    self.performSegue(withIdentifier: "registrarSegue", sender: nil)
                })
                let btnCancel = UIAlertAction(title: "Cancelar", style: .default, handler: {(UIAlertAction) in
                    
                })
                alerta.addAction(btnOk)
                alerta.addAction(btnCancel)
                self.present(alerta, animated: true, completion: nil)
            }else{
                
                let usuario = self.TextUsuario.text
                print("Inicio de sesion exitoso")
                print("usuariooo\(String(describing: usuario))")
                self.performSegue(withIdentifier: "logueadoSegue", sender: usuario)
            }
            
        }
    }
    
    
    
    @IBAction func Regsitrarse(_ sender: Any) {
        performSegue(withIdentifier: "registrarSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

