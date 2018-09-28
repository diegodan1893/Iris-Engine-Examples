-- Definition of characters
local s = Character.new("sakura")

-- Definition of character sprites
sakuraPong = CharacterSprite.new("sakura1.png", Position.center, 200)
sakuraPong:setPosition(58, 1160)

-- Tutorial script
sleep(0.5)
sakuraPong:show("smiling")
sleep(0.3)

s "Te doy la bienvenida a la pista de Pong."

sakuraPong:show("normal")

s "Deja que te explique cómo jugar."

sakuraPong:show("serious eyes closed")

s "Verás, este motor aún está en desarrollo y todavía no es posible comprobar desde un script qué teclas del teclado se están pulsando, así que controlarás el juego usando el ratón."

local q = Question.new{
	"¡Vamos allá!", true,
	"Repíteme los controles", false
}

repeat
	sakuraPong:show("normal")

	s "La raqueta de la izquierda es la tuya.\nYo jugaré con la de la derecha."
	s "Mientras mantengas el ratón en el centro de la ventana tu raqueta no se moverá."
	s "Si colocas el ratón en la parte superior de la ventana la raqueta se moverá hacia arriba."
	s "Y, como habrás deducido, si colocas el ratón en la parte inferior la raqueta se moverá hacia abajo."
	s "El primero en conseguir tres puntos gana."

	sakuraPong:show("eyes closed")

	s "¿Preparado?"

	q:ask()
until q.answer

sakuraPong:show("happy")

s "¡Que gane el mejor!"

hideText()
sakuraPong:hide()