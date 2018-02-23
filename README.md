# Configurando o Ambiente:

--- 
Todas as dependencias estão gerenciadas via cocoapods, após clonar este repositório, por favor abra o terminal
na pasta do projeto "KiddoTeste" e digite: pod install<p>
Aguarde até que todos os pods sejam instalados no seu novo workspace.
Após isto, abra o arquivo KiddoTeste.xcworkspace.

### Documentação do sistema:

- Removido o Safe area layout guide das storyboard devido à compatibilidade a partir da versão 9,
o target do aplicativo, conforme o solicitado no enunciado da avaliação é a partir de 8.x

- Toda configuração dos Collection Items foram feitas no storyboard para não poluir o código e centralizar
a confecção da interface no interfacebuilder

- A configuração da aparencia padrão do aplicativo foi feito no app delegate, no MainTabBar estão as configurações dos
botões da TabBar.

- Para a navegação entre o detalhamento e compra, para que possa criar o efeito zoom e também uma navegação no aplicativo
utilizando a NavigationBar foi criado um NavigationController isolado, sem segue para que possa fazer sem maiores
dificuldades toda a trasição do aplicativo, quando finalizar todo o processo de compra e favoritos, basta fechar este
modal.

- O Banco de dados utilizado foi o Coredata, não gosto de utilizar o Coredata com a configuração padrão do xcode poisexistem alguns problemas de performance e caso seja necessário criar um novo banco de dados ou fazer a migração, basta duplicar oesta biblioteca(desenvolvida por mim) "MovieDatabaseManager" e associar ao novo xdatamodel que foi criado e dar um novo nome ao sqlite que será criado automáticamente, existe também o gerenciador de migração já implementado.

- O controller do banco de dados está retornando diretamente seus valores para um MovieData e também recebe um MovieData para inserir um novo filme na base de dados.

- Utilizei o AFNetworking e criei um service para fazer toda operação de request e response necessária(no caso da API utilizei somente get) e criei um APIManager para que basta chamar um determinado request e o bloco de response vai se responsabilizar por entregar o MovieData parseado para que seja criada as celulas e exibidas na CollectionView

- Apesar de não estar especificado, implementei a funcionalidade de compartilhar filmes utilizando UIActivityViewController e as opções de compartilhamento do proprio iOS.


### Testes:
Criei alguns testes automatizados utilizando o KIF, os testes são:
1. Use case Favoritar Filme Minions:<p>
Usuário seleciona a tab "Home" -> Usuário seleciona o filme "Minions" -> Usuário pressiona o botão "Add aos favoritos" ->
Usuário volta para a tela principal

1. Use case "Desfavoritar" Filme Minions:<p>
Usuário seleciona a tab "Favoritos" -> Usuário seleciona o filme "Minions" -> Usuário pressiona o botão "Remover dos favoritos" ->
Usuário volta para a tela principal

1. Use case Comprar Filme Minions:<p>
Usuário seleciona a tab "Home" -> Usuário seleciona o filme "Minions" -> Usuário pressiona o botão "Comprar" ->
Usuário seleciona a opção "VUDU - SD - Alugar: 3 Dias"

### Bugs conhecidos:

- Problema ao gerenciar a tela de detalhamento de filmes no modo landscape, devido ao prazo, não tive tempo de readaptar a View para dentro de uma UIScrollView.


