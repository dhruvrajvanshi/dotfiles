function ls --wraps=eza --description 'alias ls eza'
  if type -q "eza"
    eza $argv
  else 
    ls $argv
  end
end
