function translateNetworkError(errcode, connecting, errdesc)
  local text
  if errcode == 111 then
    text = tr('Conexao recusada, O servidor pode estar offline ou reiniciando.\nEspere um pouco e tente novamente.')
  elseif errcode == 110 then
    text = tr('Tempo de conexao falhou. Você pode estar sem internet ou o servidor offline.')
  elseif errcode == 1 then
    text = tr('A conexao falhou, O endereço do servidor não existe.')
  elseif connecting then
    text = tr('Conexao falhou.')
  else
    text = tr('Você perdeu a conexão com a internet ou o servidor está offline.')
  end
  text = text .. ' ' .. tr('(ERRO %d)', errcode)
  return text
end
