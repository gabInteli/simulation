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
Inicialmente foi preciso criar um arquivo Python que conterá o código do servidor Flask. Nesse arquivo, você precisará importar o módulo Flask e definir uma instância da classe Flask para o seu aplicativo. Por exemplo:
</br>

`from flask import Flask`
</br>

`app = Flask(__name__)`

## Construção 
Em seguida, foram definidas as rotas para o aplicativo, que correspondem a URLs específicas que o usuário pode acessar. 

1. A primeira rota consiste na interface inicial do aplicativo, responsável por interagir com o usuário para a inserção de dados. 

```
from flask import render_template

@app.route('/')
def index():
    return render_template('index.html')
```

2. A segunda rota é responsável por captar os dados fornecidos pelo usuário na interface e enviar esses dados para o banco de dados estruturado por meio da biblioteca SQLAlchemy: 

```
@app.route('/post', methods=["POST"])
def postForm():
    print(request.form)
    c1 = Coordenate(x=request.form['x'], y=request.form['y'], z=request.form['z'])

    session.add(c1)
    session.commit()
    return render_template('index.html', x=request.form['x'], y=request.form['y'], z=request.form['z'])

```

3. A terceira rota se trata da responsável por atuar como um endpoint para o software Godot receber as informações de posição do elemento: 

```
@app.route('/godot', methods=["GET", "POST"])
def godot_coords():
    coordenadas = session.query(Coordenate).all()
    if coordenadas:
        x = coordenadas[-1].x
        y = coordenadas[-1].y
        z = coordenadas[-1].z
    godotstring = f"{x}/{y}/{z}"
    return godotstring 
```

## Front-end 

Agora, para criar uma interface de frontend, foi necessário utilizar as rotas definidas no backend que renderizam modelos HTML. Flask usa um mecanismo de modelo chamado Jinja2, que permite criar modelos HTML dinâmicos que incluem variáveis, loops e condicionais.

## Construção

Inicialmente foi criada uma pasta responsável por armazenar os modelos de páginas HTML, chamada "templates". 

Para criar um modelo Jinja2, foi criado um arquivo `index.hmtl` e adicionadas as tags Jinja2 que seriam responsáveis por receberem valores do servidor.

![img](https://github.com/gabInteli/simulation/blob/main/src/static/images/readme1.png)

Para renderizar esse modelo em uma rota, foi utilizada a função render_template do Flask.

```
from flask import render_template

@app.route('/')
def index():
    return render_template('index.html')
```

### Interface 
Foi desenvolvida uma interface que consiste em um formulário HTML que permite capturar as coordenadas x, y e z. Essas coordenadas são usadas para controlar uma simulação no Godot. Além disso, a interface é responsável por criar um novo registro de coordenadas em um banco de dados e direcionar a simulação no Godot para essas coordenadas.

Então, quando um usuário preenche o formulário HTML com as coordenadas, a interface envia essas informações para o programa Godot, permitindo que a simulação seja executada nas coordenadas especificadas pelo usuário. E todas as coordenadas coletadas são armazenadas em um banco de dados para referência futura.

![img](https://github.com/gabInteli/simulation/blob/main/src/static/images/readme2.png)

## Banco de Dados 
### Construção 
o Banco de dados foi criado utilizando a linguagem de programação SQL (Structured Query Language). O banco de dados em questão foi desenvolvido através do uso da biblioteca específica do Python denominada SQLAlchemy, a qual fornece uma interface de banco de dados ORM (Object-Relational Mapping). Essa interface permite que os desenvolvedores interajam com o banco de dados por meio de objetos em vez de escrever SQL diretamente.

O banco de dados em questão tem sua estrutura baseada em coordenadas armazenadas em um sistema de eixos tridimensionais. As coordenadas são representadas por três valores numéricos correspondentes às posições em x, y e z. As colunas do banco de dados são estruturadas com base nessas posições, e cada célula do banco é preenchida com um valor inteiro. 

![img](https://github.com/gabInteli/simulation/blob/main/src/static/images/readme3.png)

## Instruções de Acesso 
### Interface 
1. Para acessar a interface de inserção de dados basta acessar a pasta "src": 
</br>

`cd src`

2. Em seguida basta iniciar o servidor com o comando: 
</br>

`python main.py`

3. Por fim, basta acessar o endereço apontado pelo servidor. 

![img](https://github.com/gabInteli/simulation/blob/main/src/static/images/readme4.png)


### Banco de Dados 

Para acessar o banco foi utilizado o software "DBBrowser", porém ele pode ser acessador por diversos outros que permitem a visualização do banco. 

Basta apenas abrir o arquivo contido na pasta "src" e entitulado como: 
`coordenates.db`

### Simulação 

*Obs.: Devido a restrições de armazenamento do GitHub em relação a tamanho de arquivos, por conta do arquivo .obj responsável pelo Mesh3D do braço robótico, foi necessário encapsular o arquivo Godot em uma pasta zipada que ao abrir o repositório localmente deve ser descompactada.*

1. Para acessar a simulação basta abrir inicialmente o software Godot. 

2. Em seguida é necessário importar o arquivo contido na pasta que foi descompactada, o arquivo tem a nomeclatura: `project.godot`

3. Ao abrir o arquivo, incialmente é necessário alterar a variável de URL do Script "Spacial.gd", pois o endereço de IP do endpoint irá variar de acordo com cada máquina e a rede wifi conectada. 

4. Por fim basta iniciar a simulação em "Run" no software Godot. 

5. Para acompanhar a atualização dos dados constante basta ativar o botão de "Ativar Captação de Dados". 