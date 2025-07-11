import { WebPlugin } from '@capacitor/core';

import type { PhotoEditorPluginPlugin } from './definitions';

export class PhotoEditorPluginWeb extends WebPlugin implements PhotoEditorPluginPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
