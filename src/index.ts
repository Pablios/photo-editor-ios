import { registerPlugin } from '@capacitor/core';

import type { PhotoEditorPluginPlugin } from './definitions';

const PhotoEditorPlugin = registerPlugin<PhotoEditorPluginPlugin>('PhotoEditorPlugin', {
  web: () => import('./web').then((m) => new m.PhotoEditorPluginWeb()),
});

export * from './definitions';
export { PhotoEditorPlugin };
