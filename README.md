# README

Teste para backend - Speedio

Este projeto é uma API para scraping de dados.

Não foi utilizado nenhum automatizador de navegador no processo de scraping, apenas as funcionalidades da gem nokogiri.

https://www.similarweb.com sempre retorna Erro 403 para tentativas de scraping, para os fins deste teste a página foi salva offline e usada como alvo para desenvolvimento do scraper, url pode ser alterada na controller.


Notas sobre o projeto:

* Ruby v3.3.0, Rails v7.1.3.2 

* Para executar, rodar 
```
bundle install
rails s
```


* Projeto configurado para rodar com instância local do MongoDB.

* Ambos endpoints recebem url como parâmetro do POST.

* Nome do endpoint foi corrigido de "salve_info" para "save_info".

* Suite de testes automatizados foi despriorizada por questões de tempo, e por não estar listada como fator determinante na descrição do teste. No entanto, tendo a oportunidade, pretendo retomar o projeto e desenvolver testes para a controller e model presentes no projeto.