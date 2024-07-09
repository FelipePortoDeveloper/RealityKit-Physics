//
//  ContentView.swift
//  RealityPhysics
//
//  Created by Felipe Porto on 09/07/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Criando um material
    
        let material = SimpleMaterial(color: .purple, isMetallic: true)
        
        // Criando um mesh
        
        let mesh = MeshResource.generateBox(size: 0.2, cornerRadius: 0.005)
        
        // Criando uma entidade
        
        let box = ModelEntity(mesh: mesh, materials: [material])
        
        // Criando uma ancora
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        // Adicionando a caixa na ancora
        
        anchor.addChild(box)
        
        // Adicionando a ancora na cena
        
        arView.scene.anchors.append(anchor)

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
