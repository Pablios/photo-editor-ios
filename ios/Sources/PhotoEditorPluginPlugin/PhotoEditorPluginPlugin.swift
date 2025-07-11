import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(PhotoEditorPluginPlugin)
public class PhotoEditorPluginPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "PhotoEditorPluginPlugin"
    public let jsName = "PhotoEditorPlugin"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "edit", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = PhotoEditorPlugin()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func edit(_ call: CAPPluginCall) {
        implementation.edit(call)
    }
}
