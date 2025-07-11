import Capacitor
import UIKit
import TOCropViewController

@objc(PhotoEditorPlugin)
public class PhotoEditorPlugin: CAPPlugin, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate {
    
    var call: CAPPluginCall?
    var picker: UIImagePickerController!
    var cropViewController: TOCropViewController!
    
    @objc func edit(_ call: CAPPluginCall) {
        self.call = call

        guard let imagePath = call.getString("imagePath") else {
            call.reject("Parâmetro 'imagePath' não fornecido.")
            return
        }

        let cleanPath = imagePath.replacingOccurrences(of: "file://", with: "")
        let imageURL = URL(fileURLWithPath: cleanPath)

        guard let image = UIImage(contentsOfFile: imageURL.path) else {
            call.reject("Não foi possível carregar a imagem no caminho fornecido: \(cleanPath)")
            return
        }

        DispatchQueue.main.async {
            self.cropViewController = TOCropViewController(image: image)
            self.cropViewController.delegate = self

            if let topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                var presented = topController
                while let next = presented.presentedViewController {
                    presented = next
                }

                presented.present(self.cropViewController, animated: true)
            } else {
                self.call?.reject("Erro ao abrir editor de imagem.")
            }
        }

    }


    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            call?.reject("Erro ao selecionar imagem")
            return
        }

        self.cropViewController = TOCropViewController(image: image)
        self.cropViewController.delegate = self
        self.bridge?.viewController?.present(self.cropViewController, animated: true)
    }

    public func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true)
        
        guard let imageData = image.jpegData(compressionQuality: 0.9) else {
            call?.reject("Erro ao processar imagem")
            return
        }
        
        let base64 = imageData.base64EncodedString()
        call?.resolve([
            "base64": "data:image/jpeg;base64,\(base64)"
        ])
    }

    public func cropViewControllerDidCancel(_ cropViewController: TOCropViewController) {
        cropViewController.dismiss(animated: true)
        call?.reject("Edição de imagem cancelada pelo usuário.")
    }

    @objc public func echo(_ value: String) -> String {
        return value
    }
}
