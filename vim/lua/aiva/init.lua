local G = {}

function G.tprint(t)
  print('table starts print')
  for index, value in ipairs(t) do
    print(index, value)
  end
end

function G.greetter()
  print('Greetings from ' .. 'aiva.init.luaa')
end

return G
