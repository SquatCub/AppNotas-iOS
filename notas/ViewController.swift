//
//  ViewController.swift
//  notas
//
//  Created by Brandon Rodriguez Molina on 12/04/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Table view methods
    
    let notas = ["Ir al super", "Salir a caminar", "Hacer la tarea"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNotas.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        celda.textLabel?.text = notas[indexPath.row]
        return celda
    }
    
    
    @IBOutlet weak var tablaNotas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tablaNotas.delegate = self
        tablaNotas.dataSource = self
    }
    @IBAction func addNotaButton(_ sender: Any) {
        let alerta = UIAlertController(title: "Agregar", message: "Nueva nota", preferredStyle: .alert)
        let accion = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alerta.addAction(accion)
        
        present(alerta, animated: true, completion: nil)
    }
    

}

