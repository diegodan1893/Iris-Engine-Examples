-- Definition of characters
local s = Character.new("???")
local h = Character.new("Haru")

-- Definition of character sprites
local sakura = CharacterSprite.new("sakura1.png")

-- Definition of other sprites
local logo = Sprite.new("logo.png", 1)

local animated1 = Sprite.new("animated.png", 1)
local animated2 = Sprite.new("animated.png", 1)
local animated3 = Sprite.new("animated.png", 1)

local script1 = Sprite.new(lang .. "script1.png", 1)
script1:setPosition(100, 120)
local script2 = Sprite.new(lang .. "script2.png", 1)
script2:setPosition(100, 120)
local script3 = Sprite.new(lang .. "script3.png", 1)
script3:setPosition(100, 120)
local script4 = Sprite.new(lang .. "script4.png", 1)
script4:setPosition(100, 120)
local script5 = Sprite.new(lang .. "script5.png", 1)
script5:setPosition(100, 120)

local characters = Sprite.new("characters.png", 1)
characters:setPosition(100, 90)

-- Manually precache some images so that transitions are more smooth
precacheImage("assets/images/characters/sakura2.png")
precacheImage("assets/images/characters/sakura2 normal.png")
precacheImage("assets/images/characters/sakura1 smiling.png")

-- Useful transitions
local blockingDissolve = {type=Transition.dissolve, time=0.3, block=true}

-- Script
scene("sky day.png", 1.5)

playMusic("Pond.ogg")

say "Voy de camino a casa."
say "Hace buen tiempo, el cielo está relativamente despejado y se puede oír el piar de algunos pájaros a lo lejos."

hideText()
scene("street day.png", 1)

say "El camino es bastante largo, pero no puedo decir que se me haga pesado."
say "Muchas veces me pierdo en mis pensamientos y para cuando me quiero dar cuenta ya he llegado a mi destino, así que no me aburro."

s "Perdona..."
h "(¿Eh? ¿Me ha llamado alguien?)"

sakura:show("normal")
s.name = "Chica"

say "Me giro un momento y veo a una chica que parece querer algo."
h "¿Sí?"
s ("Hola. Te llamas " .. h.name .. ", ¿verdad?")
s "¿Tienes un momento? Quiero hablarte de algo muy interesante."

-- First question
local function myName()
	h "¿Cómo sabes tú mi nombre?"

	sakura:show("smiling")

	s "No te preocupes por esos detalles sin importancia."
	h "¿Sin importancia...?"
	say "..."
	h "(Bueno, tampoco tengo nada mejor que hacer.)"
	h "Está bien, cuéntame."
end

local function haveTime()
	h "(Bueno, tampoco tengo nada mejor que hacer.)"
	h "Sí, claro. Adelante, cuéntame."
end

local function dontHaveTime()
	h "No, lo siento, tengo cosas que hacer."
	h "(Y probablemente solo quiere hacer propaganda de alguna secta religiosa o algo.)"

	sakura:show("serious")

	s "Oh, vaya. Qué pena."
	s "Bueno, entonces te dejo en paz."
	s "Adiós."
	h "Adiós."

	hideText()
	scene("black.png", 1)

	say "Después de aquello cada uno siguió su camino y nunca volvimos a vernos."
	say "Aún me pregunto por qué sabía mi nombre, pero supongo que nunca lo sabré."

	badEnd()
end

local function doIKnowYou()
	h "¿Nos conocemos?"

	sakura:show("serious")

	s "No que yo sepa."
	h "Hum..."
	h "(Tengo la sensación de que esto ya lo he vivido antes.)"
	h "(Y de que aquí hay un chiste que se está perdiendo...)"
	h "(En fin...)"
	h "¿Y qué es lo que querías contarme?"
end

local q = Question.new{
	"¿Cómo sabes mi nombre?", myName,
	"Sí, claro, adelante", haveTime,
	"No tengo tiempo", dontHaveTime,
	"¿Nos conocemos?", doIKnowYou
}
q:ask()

sakura:show("normal")

s.name = "Sakura"
s ("Verás, me llamo " .. s.name .. " y vengo de parte de Diego para hablarte de un motor que ha creado desde cero para hacer novelas visuales.")
h "¿Desde cero?"
s "Bueno, usa algunas bibliotecas de C++ para cargar los archivos, dibujar en pantalla y reproducir sonidos y música. Tampoco era necesario reinventar la rueda."
h "Y lo dice después de crear un motor para novelas visuales cuando existen ya un montón."

sakura:show("serious")

s "A mí no me mires, yo solo estoy aquí para transmitir la información."
h "Es verdad."

sakura:show("normal")

s "Bueno, ¿por dónde empiezo...?"

sakura:show("happy")

s "Ah, ya sé. Por el texto. Es una parte fundamental de las novelas visuales."
h "De acuerdo."
h "(Se la ve muy entusiasmada.)"
s "El tamaño y la posición de la zona en la que aparece el texto que estás leyendo ahora mismo son completamente personalizables para cada juego. Y el fondo también."
s "Y, como puedes ver, tiene soporte para fuentes no monoespaciadas, lo que significa que la letra 'i', por poner un ejemplo, es menos ancha que la letra 'm'."
s "Es algo que se echa de menos en algunos motores japoneses."
s "¡Ah! ¿Y sabes qué? También soporta texto en cualquier idioma. ¡Mira, mira!"
h "A ver..."

sakura:show("laughing")

s "ちゃろー！"

q = Question.new{
	"ちゃろー☆！", 1,
	"ちゃろーですよ", 2,
	"Cha... ¿qué?", 3
}
q:ask()

if q.answer == 3 then
	sakura:show("normal")

	s "Charō."
	s "Se ve que no estás muy puesto en nuestra jerga. Me decepcionas."
	s "Bueno, en realidad era una broma interna..."
end

sakura:show("eyes closed")

s "Y, por supuesto, se pueden mezclar varios idiomas en la misma línea sin problemas (日本語)."

sakura:show("normal")

s "Eso sí, la fuente debe tener todos los caracteres necesarios."
h "Ya veo."

s "Bueno, eso es todo lo que quería decir sobre el texto. Pasemos a otra cosa."
s "Mmm... ¿Qué te parece si ahora hablamos de la parte visual?"
h "Me parece bien."
s "Seguramente ya habrás visto que las cosas no aparecen y desaparecen sin más, sino que hay transiciones que suavizan los cambios."
s "Pues haciendo pruebas descubrí un efecto muy interesante que puede conseguirse con ellas."
s "Mira, me voy a apartar para que lo puedas ver bien."
h "De acuerdo."

sakura:hide()
fadeOutMusic(3)

s "Atento, ¿eh?"
h "Sí, sí."
s "Que empieza. Dale clic."

hideText()
scene("street evening.png", 3)

h "¡Está atardeciendo!"
s "Sí. Qué rápido pasa el tiempo, ¿verdad?"

sakura:show("normal")

s "Y pronto anochecerá."

setBackground("street night.png", {type=Transition.dissolve, time=300, block=false})
playMusic("Inspiration.ogg")

s "Bueno, sigamos."

hideText()
sakura:moveX(990, 0.3, false)
sleep(0.1)
sakura:setBase("sakura2.png", "sakura2.png", "normal", blockingDissolve)

s "Como puedes ver, además de hacer fundidos también es posible mover los sprites por la pantalla."

logo:setPosition(100, 100)
logo:show()
sakura:setBase("sakura3.png", "sakura2.png", "normal", blockingDissolve)

s "Y poner cualquier imagen en cualquier sitio."

animated1:setPosition(250, 312)
animated1:defineSpriteSheet(89, 13, 7, 60)
animated1:show()

animated2:setPosition(350, 382)
animated2:defineSpriteSheet(89, 13, 7, 30)
animated2:show()

animated3:setPosition(450, 302)
animated3:defineSpriteSheet(89, 13, 7, 120)
animated3:show()

s "¡Incluso sprites animados a partir de sprite sheets!"

sakura:show("laughing")

s "¡Mira cómo dan vueltas esos octógonos!"

sakura:setBase("sakura2.png", "sakura2.png", "smiling")

s "¿A que es genial?"
h "Eh... ¡claro!\n(Pero son hexágonos...)"

sakura:show("normal")

s "Bueno, con esto ya terminamos esta parte."
s "Voy a limpiar un poco la pantalla."

hideText()
logo:hide()
animated1:hide()
animated2:hide()
animated3:hide()

sleep(0.3)

sakura:move(Position.center, 0.3, false)
sleep(0.1)
sakura:setBase("sakura1.png", "sakura1.png", "smiling", blockingDissolve)

s "¿Seguimos?"

q = Question.new{
	"¡Claro!", 1,
	"Me estoy aburriendo", 2
}

q:ask()

if q.answer == 2 then
	sakura:show("angry")

	s "¡Pues lo siento mucho, pero de aquí no te vas hasta que termine de explicártelo todo!"
	h "¡¿Qué?!"
	say "..."
	h "(Qué se le va a hacer...)"
	h "Está bien, te escucharé."
end

sakura:show("normal")

s "Bien. Pues ahora llega la parte más importante de todas."
h "¿Cuál?"
s "Cómo escribir una novela visual larga sin morir en el intento: los scripts."
h "Es importante, sí."

sakura:show("eyes closed")

s "Evidentemente, cambiar el código del motor en C++ y recompilar no es la mejor solución."
s "Normalmente los escritores no tienen experiencia programando, y aunque la tuvieran, con la cantidad de texto que tiene una novela visual sería una pesadilla."
h "Ya imagino."

sakura:show("normal")

s "Por lo tanto, es muy importante que escribir los diálogos sea fácil y rápido."

hideText()
sakura:moveX(990, 0.3, false)
sleep(0.1)
sakura:setBase("sakura2.png", "sakura2.png", "normal", blockingDissolve)

s "Deja que te enseñe la pinta que tienen los scripts de este motor."

transitions.showFadeLeft(script1)
sakura:setBase("sakura3.png", "sakura2.png", "normal")

s "El código que ves en pantalla se corresponde con lo que va a ocurrir a continuación."

s "En primer lugar, se definen variables para los personajes."
s "Así no hay que escribir el nombre de la persona que habla todo el rato."
h "Entiendo."
s "Luego basta con poner esa variable seguida del texto entre comillas."
s "Así de fácil."
s "Como ves, una vez definidos los personajes, no es muy distinto a escribir un guión normal y corriente."
s "Y para la comodidad de los escritores, si una línea es demasiado larga para caber en una página, se dividirá en dos automáticamente."
s "También es posible introducir\nsaltos de línea con \\n."

transitions.hideFadeLeft(script1)
sakura:setBase("sakura2.png", "sakura2.png", "normal")

s "También son muy importantes los sprites de los personajes y sus expresiones faciales."

transitions.showFadeLeft(characters)

s "Tenemos una imagen base del personaje sin cara y un conjunto de imágenes con las expresiones que puede poner."

sakura:setBase("sakura3.png", "sakura2.png", "normal")

s "Esto permite reutilizar las mismas expresiones con diferentes imágenes base, útil cuando tenemos al mismo personaje con varios atuendos o dos sprites con posturas muy similares, como cuando yo extiendo la mano."

sakura:setBase("sakura2.png", "sakura2.png", "normal")
transitions.hideFadeLeft(characters)

s "Ahora, veamos un script en el que se cambian las expresiones."

transitions.showFadeLeft(script2)

sakura:show("smiling")
s "Ahora estoy sonriendo."
sakura:show("normal")
s "Ahora estoy normal."
sakura:show("laughing")
s "Ahora me estoy riendo."

sakura:setBase("sakura3.png", "sakura2.png", "normal")

s "Y, por supuesto, es posible cambiar la velocidad de la transición o eliminarla por completo."

transitions.hideFadeLeft(script2)
sakura:setBase("sakura2.png", "sakura2.png", "cheerful")

s "Pero aún hay más."
s "La facilidad de uso es muy importante, pero el lenguaje también tiene que ser flexible y potente."
s "Hay desarrolladores a los que les encanta poner minijuegos en sus novelas."
s "Aunque no hay que ir tan lejos. A veces simplemente es útil reducir cierta secuencia de comandos a una sola línea porque se repite mucho, como una transición especial o algo parecido."
h "Tiene sentido."
s "¿Pues sabes qué?"

sakura:show("happy")

s "Todo el código que has visto hasta ahora tiene una sintaxis 100% válida en Lua."
s "De hecho, los scripts de este motor se programan en Lua."
s "Es un lenguaje de programación completo con el que se puede hacer cualquier cosa, pero con una sintaxis tan sencilla que los que no lo sepan ni se darán cuenta de que están programando."
s "Ya has visto antes cómo se escribían los diálogos."

sakura:setBase("sakura3.png", "sakura2.png", "normal")

s "Veamos algunos ejemplos de cosas interesantes que se pueden hacer."

transitions.showFadeLeft(script3)

s "Empecemos por algo sencillo. Voy a contar hasta cinco."

for i = 1, 5 do
	s (i)
end

transitions.hideFadeLeft(script3)

s "Bueno, quizá eso era demasiado básico."

transitions.showFadeLeft(script4)

s "Veamos ahora algo mucho más interesante."
s "Elige. ¿Cara o cruz?"

-- We will associate a number to each option
q = Question.new{
	"Cara", 0,	-- A value of 0 will mean heads
	"Cruz", 1	-- A value of 1 will mean tails
}

-- Ask the player to choose
q:ask()
s "A ver qué ha salido..."

-- Compare the answer with a randomly generated number between 0 and 1
if q.answer == math.random(0, 1) then
	s "¡Enhorabuena! ¡Has acertado!"
else
	s "¡Qué pena! Has tenido mala suerte."
end

transitions.hideFadeLeft(script4)

s "¿Qué tal si vemos otro ejemplo más práctico?"
s "En muchos videojuegos hay momentos en el que el jugador tiene que hacerle un número determinado de preguntas a un personaje y puede escoger en qué orden hacerlas."
s "Veamos cómo se hace aquí."

transitions.showFadeLeft(script5)

-- Choices
local function weather()
	h "Hablemos del tiempo."
	s "Hoy ha hecho muy buen tiempo, aunque ahora empieza a hacer un poco de frío."
end

local function pets()
	h "¿Prefieres los gatos o los perros?"
	s "Yo soy más de conejos."
	h "Ah, ya..."
end

local function sociopolitical()
	h "¿Qué opinas de la situación sociopolítica del país y del mundo en general?"
	s "Nada."
	h "Ah, vale."
end

-- Create the question
q = Question.new{
	"Del tiempo", weather,
	"¿Perros o gatos?", pets,
	"De la situación sociopolítica", sociopolitical
}

-- Remove options after the player selects them
q.removeAfterSelection = true

-- Question loop
while q.count > 0 do
	-- Text of the question
	s "¿De qué quieres que hablemos?"

	-- Show the choices to the player
	q:ask()
end

hideText()
transitions.hideFadeLeft(script5)
sleep(0.5)

sakura:move(Position.center, 0.3, false)
sleep(0.1)
sakura:setBase("sakura1.png", "sakura1.png", "normal", blockingDissolve)

s "Y eso es todo sobre los scripts."

sakura:show("happy")

s "Es un sistema tan flexible que es posible implementar el juego Pong con este motor. ¿Qué te parece?"

-- Options
local function great()
	h "Me parece genial."

	sakura:show("smiling")

	s "Me alegro."

	hideText()
	fadeOutMusic(2)
	scene("black.png", 1)
	sleep(0.5)

	say "Después de aquello, estuvimos hablando un poco más sobre cosas sin importancia."
	hideText()
end

local function dontBelieve()
	sakura:show("normal")

	h "Me lo creeré cuando lo vea."

	sakura:show("eyes closed")

	s "Esperaba que dijeras eso."

	sakura:show("normal")

	s "Sígueme."

	hideText()
	fadeOutMusic(2)
	scene("black.png", {type=Transition.imageDissolve, image="wipe right.png", time=1})
	sleep(0.5)

	-- Start Pong minigame
	dofile("assets/scripts/pong/pong.lua")
	pong.init()
	pong.tutorial()

	local playerWon = pong.play()

	local qWin = Question.new{
		"Vale, volvamos a jugar", true,
		"Mejor lo dejamos para otro día", false
	}

	local qLose = Question.new{
		"¿Eres capaz de repetirlo?", true,
		"Ya te ganaré otro día", false
	}

	local continue = false

	while not continue do
		if playerWon then
			sleep(0.5)
			sakuraPong:show("nervious")
			sleep(0.3)

			s "¿He perdido?"

			sakuraPong:show("angry")

			s "¡No puede ser! ¡Seguro que has hecho trampa!"
			s "¡Quiero la revancha!"

			qWin:ask()

			if qWin.answer then
				h "Muy bien, pero el resultado no va a cambiar."
				s "¡Esta vez pienso ganar!"

				hideText()
				sakuraPong:hide()

				playerWon = pong.play()
			else
				h "No, mejor lo dejamos para otro día."

				hideText()
				sakuraPong:hide()
				continue = true
			end
		else
			sleep(0.5)
			sakuraPong:show("eyes closed")
			sleep(0.3)

			s "Je, je, je."

			sakuraPong:show("normal")

			s "¿Qué te ha parecido enfrentarte a la mejor jugadora de Pong del mundo?"

			qLose:ask()

			if qLose.answer then
				h "¿Eres capaz de repetirlo?"

				sakuraPong:show("eyes closed")

				s "Por supuesto."

				hideText()
				sakuraPong:hide()

				playerWon = pong.play()
			else
				h "Otro día no tendrás la misma suerte."

				hideText()
				sakuraPong:hide()
				continue = true
			end
		end
	end

	scene("black.png", {type=Transition.imageDissolve, image="wipe right.png", time=1})
	sleep(1)
end

q = Question.new{
	"Me lo creeré cuando lo vea", dontBelieve,
	"Genial", great
}
q:ask()

scene("street night.png")

h "Qué tarde se ha hecho."

sakura:show("normal")

s "Es verdad."
s "Hace un poco de frío. ¿Quieres que vayamos a algún otro sitio y sigamos hablando allí de la parte técnica?"

-- Options
local function tooLate()
	h "No, ya se ha hecho muy tarde, lo siento."

	sakura:show("eyes closed")

	s "Tienes razón, mejor lo dejamos para otra vez."

	sakura:show("normal")

	s "¡Nos vemos!"
	h "¡Hasta luego!"
end

local function technical()
	h "Sí, sigamos hablando."

	hideText()
	scene("black.png", {type=Transition.imageDissolve, image="wipe right.png", time=1})
	sleep(0.5)
	scene("lookout.png", {type=Transition.imageDissolve, image="wipe right.png", time=1})

	playMusic("Pond.ogg")

	say "Al final acabamos en un mirador desde el que se puede ver toda la ciudad."
	say "No es que aquí haga menos frío que donde estábamos antes, pero qué se le va a hacer."

	sakura:show("normal")

	s "¿Seguimos?"
	h "Cuando quieras."

	sakura:setBase("sakura2.png", "sakura2.png", "normal")

	s "Bien. Ahora voy a hablar un poco por encima de la parte técnica."

	sakura:setBase("sakura3.png", "sakura2.png", "normal")

	s "Este motor está inspirado un poco en el Siglus, de Visual Art's, en lo que se puede aprender de él viéndolo funcionar en otros juegos y estudiando sus archivos de configuración."
	s "También está inspirado en el motor de los Ace Attorney de 3DS."

	sakura:setBase("sakura2.png", "sakura2.png", "normal")

	s "Como estos juegos usan modelos 3D en un entorno con RAM muy limitada, es fácil saber cómo maneja sus recursos observando las pantallas de carga."
	s "Ambos parecen hacer algo muy similar, y es la técnica que utiliza este motor."

	sakura:setBase("sakura3.png", "sakura2.png", "normal")

	s "Los recursos se cargan de disco duro la primera vez que se necesitan."
	s "Una vez cargados, se almacenan en una caché de tamaño fijo y configurable para cada juego sin tener que recompilar el motor."
	s "Cuando no hay más espacio en la caché para nuevos archivos, se elimina el recurso que haya sido usado por última vez hace más tiempo."
	s "También existe la posibilidad de precargar parte de los recursos necesarios para un script al inicio de este, para que ya estén en memoria en el momento en el que se necesiten."

	sakura:setBase("sakura1.png", "sakura1.png", "smiling")

	s "Y ahora sí, eso ha sido todo."
	s "Espero que te haya resultado interesante."
	s "Muchas gracias por tu tiempo."
	s "¡Nos vemos!"
	h "¡Adiós!"
end

q = Question.new{
	"No, ya es muy tarde", tooLate,
	"Sí, sigamos hablando", technical
}
q:ask()

badEnd()