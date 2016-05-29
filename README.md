# ClassifiedsApp

README FIRST

Antes de tudo, olá.

Vou aqui referir o que está no projecto de maneira a contextualizar as opçōes de desenvolvimento/arquitectura do projecto.

Projecto Geral:
- Ao abrir o projecto é-nos apresentada uma vista que diz estar a fazer o load dos dados. Temos então uma lista de produtos. 
Podemos selecionar então a vista detalhada onde podemos fazer share (canto superior direito) e tem a imagem do produto maior.

- Ao selecionar qualquer row da tabela somos encaminhados a uma página onde tem os detalhes gerais do anuncio, aqui podemos também fazer swipe para o lado para ver outros anuncios.
Assim como enviar um email (apenas em devices reais) ou ligar para o anunciante.

Só foi utilizado o endpoint indicado no email. 

Técnico:

Swift - Apenas usei swift (2.2) porque no job spec do site pediam swift como opcional e no email da tarefa não referenciavam nenhuma linguagem.
Estou mais que pronto a fazer o mesmo em objective-C se assim desejarem.

Coredata - O stack é criado no Appdelegate e depois acedido pelo primeiro view controller. 
Num caso normal deveria ser feito o set do rootViewcontroller no app delegate e aí dar o stack ao root. Neste caso achei que tal não seria necessário.
Existem também classes (derivadas de NSManagedObject) para objectos de coredata que nem sao usados. Isto porque faziam sentido de um ponto de vista teorico.

Imagens - Como era para fazer tudo nativo, usei um endpoint que gera imagens aleatorias com base no tamanho.
Não faço nenhum controlo sobre as mesmas, daí que aquando do seu load elas muitas vezes apareçam repetidas. 
As imagens não são guardadas em coredata de proposito, assim carrega-as sempre. Poderia simplesmente guarda-las como NSData em coredata.
Num caso normal usar-se-ia SDWebImage, FastImageCache ou mesmo AFNetworking, qualquer uma dessas bibliotecas trata do reuse de imagens. Daí não ter sido uma prioridade.

Qualquer questão, estejam à vontade para me contactar: flaviodsilverio@gmail.com

O projecto pode não estar perfeito, no entanto foi um pouco em cima da hora e como tinha coisas muito importantes a fazer no fim de semana, acabei por não conseguir dispender tanto tempo nele como desejaria. 
No geral estou satisfeito com o que atingi neste tempo.

Obrigado.
Flávio

