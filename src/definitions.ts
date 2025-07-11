export interface PhotoEditorPluginPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
