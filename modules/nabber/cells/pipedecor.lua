prism.registerCell("PipeDecor", function()
   return prism.Cell.fromComponents {
      prism.components.Name("Pipe Decor"),
      prism.components.Collider(),
      prism.components.Drawable { index = 140 },
      prism.components.PipeDecorAutoTile(),
   }
end)
