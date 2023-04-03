# Produção de Simulação de Leitura e Execução de Movimento 

## Orientações para o Projeto 
O projeto Robô Digital tem por objetivo a elaboração de uma solução completa de integração entre as Tecnologias de Automação (TA) e as Tecnologias de Informação (TI). Trata-se de uma representação digital para um braço robótico com conexão em tempo real com sua contrapartida no mundo real. Para a construção deste sistema, será necessário construir três elementos:

- <strong>Backend</strong>: será necessário construir um backend capaz de armazenar informações como deslocamento do robô, sua posição e enviar informações em tempo real para um ambiente de simulação. Para interação com o backend, deve-se também construir uma API que permita o envio e recebimento de dados por clientes.
- <strong>Frontend</strong>: para que o usuário possa interagir com o sistema, uma aplicação Frontend deve ser construída. Ela deve possibilitar que o usuário realize requisições de deslocamento do manipulador robótico. Os deslocamentos podem ser realizados tanto em espaço de juntas como coordenadas globais. Cada deslocamento deve ser armazenado. Deve ser possível visualizar a posição atual do robô pela interface.
- <strong>Simulação</strong>: o sistema de simulação do comportamento robótico deve ser implementado utilizando uma representação tridimensional de sua cadeia cinemática. Recomenda-se a utilização da engine Godot para realizar esta implementação. O sistema de simulação deve realizar requisições para a API desenvolvida no sistema atualizar a posição-alvo do robô e receber sua posição atualizada.

## Tecnologias Utilizadas 
### Front-end:
1. Estrutura de Marcação - HTML 
2. Estética - CSS 

### Back-end:
1. Python

### Banco de Dados:
1. SQL 

### Bibliotecas - Python:
1. Flask
2. SQLAlchemy 

## Back-end
### Construção 
Inicialmente foi preciso criar um arquivo Python que conterá o código do servidor Flask. Nesse arquivo, você precisará importar o módulo Flask e definir uma instância da classe Flask para o seu aplicativo. Por exemplo:
</br>

`from flask import Flask`
</br>

`app = Flask(__name__)`

Em seguida, foram definidas as rotas para o aplicativo, que correspondem a URLs específicas que o usuário pode acessar. 

### Função 

## Front-end 

Agora, para criar uma interface de frontend, foi necessário utilizar as rotas definidas no backend que renderizam modelos HTML. Flask usa um mecanismo de modelo chamado Jinja2, que permite criar modelos HTML dinâmicos que incluem variáveis, loops e condicionais.

Inicialmente foi criada uma pasta responsável por armazenar os modelos de páginas HTML, chamada "templates". 

Para criar um modelo Jinja2, foi criado um arquivo `index.hmtl` e adicionadas as tags Jinja2 que seriam responsáveis por receberem valores do servidor.



Para renderizar esse modelo em uma rota, você precisa usar a função render_template do Flask.

```
from flask import render_template

@app.route('/pagina')
def pagina():
    mensagem = 'Bem-vindo à minha página'
    return render_template('pagina.html', mensagem=mensagem)
```
### Construção 
### Interface 
### Função 

## Banco de Dados 
### Construção 
### Função 
## Simulação 
## Instruções de Acesso 
