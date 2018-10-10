-- Definition of characters
local s = Character.new("Sakura")

-- Definition of character sprites
sakuraPong = CharacterSprite.new("sakura1.png", Position.center, 200)
sakuraPong:setPosition(58, 1160)

-- Tutorial script
sleep(0.5)
sakuraPong:show("smiling")
sleep(0.3)

s "Welcome to the Pong court."

sakuraPong:show("normal")

s "Let me explain how to play."

sakuraPong:show("serious eyes closed")

s "First, I need to tell you that since this engine is still in development, there is currently no way to access keyboard input from a script, so you'll play using the mouse."

local q = Question.new{
	"Let's go", true,
	"Can you tell me how to play again?", false
}

repeat
	sakuraPong:show("normal")

	s "The paddle on the left is yours.\nI will use the one on the right."
	s "Your paddle won't move if you keep the mouse in the center of the window."
	s "To move your paddle upwards, place the mouse over the upper part of the window."
	s "And, as you probably already guessed, to move you paddle downwards, place the mouse over the lower part of the window."
	s "The first to get three points wins."

	sakuraPong:show("eyes closed")

	s "Are you ready?"

	q:ask()
until q.answer

sakuraPong:show("happy")

s "Let the game begin!"

hideText()
sakuraPong:hide()