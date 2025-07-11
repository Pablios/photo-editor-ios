# Photo Editor IOS

Plugin para editar imagens no iOS com corte nativo usando TOCropViewController.

---

## Instalação

No seu projeto Ionic/Capacitor, rode:

```bash
npm install photo-editor-ios
npx cap sync
```

No seu arquivo `ios/Podfile`, dentro do target do app (`target 'App' do`), adicione o pod do TOCropViewController:

```ruby
target 'App' do
  capacitor_pods
  # Add your Pods here
  pod 'TOCropViewController'
end
```

Depois, rode no terminal:

```bash
cd ios/App
pod install
```

---

## Uso

No seu código TypeScript, importe e registre o plugin:

```typescript
import { registerPlugin } from '@capacitor/core';

interface PhotoEditorPlugin {
  edit(options: { imagePath: string }): Promise<{ base64: string }>;
  echo(options: { value: string }): Promise<{ value: string }>;
}

const PhotoEditorPlugin = registerPlugin('PhotoEditorPlugin') as PhotoEditorPlugin;
```

Exemplo de uso para abrir o editor com uma imagem:

```typescript
async function openEditorWithImage(path: string) {
  try {
    const result = await PhotoEditorPlugin.edit({ imagePath: path });
    console.log('Imagem editada base64:', result.base64);
    // Use a imagem base64 como quiser (exibir, salvar, etc).
  } catch (error) {
    console.error('Erro ao editar imagem:', error);
  }
}
```

---

## API

| Método | Parâmetros               | Retorno                         | Descrição                       |
|--------|-------------------------|--------------------------------|--------------------------------|
| edit   | `{ imagePath: string }` | `Promise<{ base64: string }>`  | Abre o editor para cortar imagem |
| echo   | `{ value: string }`     | `Promise<{ value: string }>`   | Retorna o mesmo valor (teste)  |

---

## Observações

- Funciona somente em iOS.
- Configure as permissões para acessar a galeria no `Info.plist`.
- Sempre rode `npx cap sync ios` após mudanças no plugin.
- Use o Xcode para compilar e debugar.
- Veja logs no console do Xcode para mensagens nativas.

---

## Licença

MIT License © Pablo
