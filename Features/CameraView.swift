//
//  CameraView.swift
//  Features
//
//  Created by Stuart Minchington on 5/1/25.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @State private var scannedCode: String?
    
    var body: some View {
        ZStack {
            SauceColors.background.edgesIgnoringSafeArea(.all)
            
            VStack {
                if let code = scannedCode {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(SauceColors.accent)
                        Text("Scanned Code Found")
                            .font(SauceTypography.headerFont)
                            .foregroundColor(SauceColors.textPrimary)
                        
                        Text(code)
                            .font(SauceTypography.bodyFont)
                            .padding()
                            .background(SauceColors.secondaryBackground)
                            .foregroundColor(SauceColors.textPrimary)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(SauceColors.accent, lineWidth: 1)
                            )
                            .textSelection(.enabled)
                        
                        Button("Scan Again") {
                            self.scannedCode = nil
                        }
                        .buttonStyle(SauceButtonStyle())
                    }
                    .padding()
                } else {
                    ZStack(alignment: .bottom) {
                        QRScannerView(scannedCode: $scannedCode)
                            .edgesIgnoringSafeArea(.all)
                        
                        Text("Point camera at a QR code")
                            .font(SauceTypography.captionFont)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .foregroundColor(SauceColors.accent)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(SauceColors.accent, lineWidth: 1)
                            )
                            .padding(.bottom, 50)
                    }
                }
            }
        }
        .navigationTitle("QR Scanner")
    }
}

struct QRScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String?
    
    func makeUIViewController(context: Context) -> QRScannerViewController {
        let controller = QRScannerViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRScannerView
        
        init(parent: QRScannerView) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                // Simple feedback
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                parent.scannedCode = stringValue
            }
        }
    }
}

class QRScannerViewController: UIViewController {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var delegate: AVCaptureMetadataOutputObjectsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return // Handle error
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let previewLayer = previewLayer {
            previewLayer.frame = view.layer.bounds
        }
    }
}
