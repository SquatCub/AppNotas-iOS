//
//  ViewController.swift
//  notas
//
//  Created by Brandon Rodriguez Molina on 12/04/21.
//

import UIKit

class ViewController: UIViewController {
    // Base de datos "local"
    var defaultsBD = UserDefaults.standard
    // Arreglo de notas
    var notas = [""]
    // Tabla
    @IBOutlet weak var tablaNotas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Asignar delegado y dataSourse a la tabla
        tablaNotas.delegate = self
        tablaNotas.dataSource = self
        // Si ya hay algo en la BD lo obtiene, sino muestra la lista vacia
        if let arregloBD = defaultsBD.array(forKey: "notas") as? [String] {
            notas = arregloBD
        } else {
            notas = []
        }
        
    }
    
    
    // Funcion para agregar nota nueva
    @IBAction func addNotaButton(_ sender: Any) {
        // Creacion de la alerta
        let alerta = UIAlertController(title: "Agregar nota", message: "", preferredStyle: .alert)
        // Creamos un textField para la alerta
        var notaTextField = UITextField()
        // Se agrega el textField a la alerta
        alerta.addTextField { (agregarNotaAction) in
            agregarNotaAction.placeholder = "Escribe aqui"
            notaTextField = agregarNotaAction
        }
        // Acciones para cuando se muestra la alerta
        let accionAceptar = UIAlertAction(title: "Ok", style: .default) { (_) in
            guard let nuevaNota = notaTextField.text else { return }
            self.notas.append(nuevaNota)
            self.tablaNotas.reloadData()
            self.defaultsBD.set(self.notas, forKey: "notas")
        }
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        // Se agregan a la alerta
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        // Mostrar la alerta con animacion
        present(alerta, animated: true, completion: nil)
    }
}
// Table view methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNotas.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        celda.textLabel?.text = notas[indexPath.row]
        return celda
    }
}

