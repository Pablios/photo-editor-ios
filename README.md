# Photo Editor iOS

Plugin for editing images on iOS with native cropping using TOCropViewController.

---

## Installation

In your Ionic/Capacitor project, run:
````markdown
```bash
npm install photo-editor-ios
npx cap sync
````

In your `ios/Podfile`, inside your app target (`target 'App' do`), add the TOCropViewController pod:

```ruby
target 'App' do
  capacitor_pods
  # Add your Pods here
  pod 'TOCropViewController'
end
```

Then, run in the terminal:

```bash
cd ios/App
pod install
```

---

## Usage

In your TypeScript code, import and register the plugin:

```typescript
import { registerPlugin } from '@capacitor/core';

interface PhotoEditorPlugin {
  edit(options: { imagePath: string }): Promise<{ base64: string }>;
  echo(options: { value: string }): Promise<{ value: string }>;
}

const PhotoEditorPlugin = registerPlugin('PhotoEditorPlugin') as PhotoEditorPlugin;
```

Example usage to open the editor with an image:

```typescript
async function openEditorWithImage(path: string) {
  try {
    const result = await PhotoEditorPlugin.edit({ imagePath: path });
    console.log('Edited image base64:', result.base64);
    // Use the base64 image as you want (display, save, etc).
  } catch (error) {
    console.error('Error editing image:', error);
  }
}
```

---

## API

| Method | Parameters              | Return                        | Description                    |
| ------ | ----------------------- | ----------------------------- | ------------------------------ |
| edit   | `{ imagePath: string }` | `Promise<{ base64: string }>` | Opens the editor to crop image |
| echo   | `{ value: string }`     | `Promise<{ value: string }>`  | Returns the same value (test)  |

---

## Notes

* Works only on iOS.
* Configure gallery access permissions in `Info.plist`.
* Always run `npx cap sync ios` after plugin changes.
* Use Xcode to build and debug.
* Check Xcode console logs for native messages.

---

## License

MIT License © Pablo
