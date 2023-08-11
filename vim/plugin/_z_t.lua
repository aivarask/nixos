wkr({
  name = 'Toggle',
  t = { 'treesitter select' },
  q = { [[:call ak#toggle_quiclfix()]], 'ak#toggle_quiclfix' },
}, { prefix = 't' })
