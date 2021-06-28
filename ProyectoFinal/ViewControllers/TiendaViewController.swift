//
//  TiendaViewController.swift
//  ProyectoFinal
//
//  Created by Mac 09 on 6/27/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit

class TiendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tablaProductos: UITableView!
    @IBOutlet weak var TextProductoNombre: UITextField!
    @IBOutlet weak var btnBuscar: UIButton!
    @IBOutlet weak var btnCompras: UIBarButtonItem!
    @IBOutlet weak var btnCerrarSesion: UIBarButtonItem!
    var adultos = [Adultos]()
    var usuario:Usuario? = nil
    var rutaa = ""
    
    @IBAction func AccesoriosVer(_ sender: Any) {
     
    }
    
    @IBAction func NiñosVer(_ sender: Any) {
     
    }
    
    @IBAction func AdultosVer(_ sender: Any) {
       
    }
    
    func cargarAdultos(ruta:String, completed: @escaping () -> ()){
        let url = URL(string: ruta)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil{
                do{
                    self.adultos = try JSONDecoder().decode([Adultos].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("Error en JSON el error: \(error)")
                    print("data cancino::\(response!)")
                }
            }
        }.resume()
    }
    
    
    @IBAction func buscarProducto(_ sender: Any) {
        let ruta = "http://localhost:3000/Adultos?"
        let nombre = TextProductoNombre.text!
        let url = ruta + "nombre_like=\(nombre)"
        let crearURL = url.replacingOccurrences(of: " ", with: "%20")
        
        if nombre.isEmpty{
            let ruta = "http://localhost:3000/Adultos/"
            self.cargarAdultos(ruta: ruta){
                self.tablaProductos.reloadData()
            }
        }else{
            cargarAdultos(ruta: crearURL){
                if self.adultos.count <= 0{
                    self.mostrarAlerta(titulo: "Error", mensaje: "No se encontraron coincidencias para: \(nombre)", accion: "cancel")
                }else{
                    self.tablaProductos.reloadData()
                }
            }
        }
    }
    
    func mostrarAlerta(titulo:String, mensaje:String, accion:String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: accion, style: .default, handler: nil)
        alerta.addAction(btnOK)
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func CerrarSesion(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("Se ha cerrado Sesion")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adultos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(adultos[indexPath.row].nombre)"
        cell.detailTextLabel?.text = "Precio: \(adultos[indexPath.row].precio)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productos = adultos[indexPath.row]
        performSegue(withIdentifier: "comprandoSegue", sender: productos)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "comprandoSegue"){
            let siguienteVC = segue.destination as! ComprandoBiciViewController
            siguienteVC.producto = sender as? Adultos
        }else{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ruta = "http://localhost:3000/Adultos/"
        cargarAdultos(ruta: ruta){
            self.tablaProductos.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaProductos.delegate = self
        tablaProductos.dataSource = self
        
         let rutaa = "http://localhost:3000/Adultos"
        cargarAdultos(ruta: rutaa){
            self.tablaProductos.reloadData()
        }
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
