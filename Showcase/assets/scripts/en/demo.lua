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

say "I'm on my way home."
say "The weather is nice, there aren't many clouds in the sky, and you can hear the chirping of birds in the distance."

hideText()
scene("street day.png", 1)

say "It's a rather long walk, but I can't say it's boring."
say "Most of the time I get lost in thought and reach my destination before I know it."

s "Excuse me."
h "(Huh? What was that?)"

sakura:show("normal")
s.name = "Girl"

say "I turn around to see a girl who appears to need something."
h "Yes?"
s ("Hi. You're " .. h.name .. ", right?")
s "Do you have a moment? I have something really interesting to tell you."

-- First question
local function myName()
	h "How do you know my name?"

	sakura:show("smiling")

	s "Don't worry about the insignificant details."
	h "Insignificant?"
	say "..."
	h "(Well, it's not like I have anything else to do right now.)"
	h "Okay, tell me."
end

local function haveTime()
	h "(Well, it's not like I have anything else to do right now.)"
	h "Of course. What is it?"
end

local function dontHaveTime()
	h "I'm sorry, but I'm busy right now."
	h "(She probably just wants to tell me about some religious sect or something anyway.)"

	sakura:show("serious")

	s "Oh, that's a shame."
	s "In that case, I won't bother you anymore."
	s "Bye."
	h "Bye."

	hideText()
	scene("black.png", 1)

	say "After that, each one walked their own path and we never met again."
	say "I still don't know why she knew my name, and I guess I never will."

	badEnd()
end

local function doIKnowYou()
	h "Do I know you?"

	sakura:show("serious")

	s "I don't think so."
	h "Hmm..."
	h "(For some reason I get the feeling that I've already had this conversation before.)"
	h "(And that there was a joke here that was lost in the final version of the game.)"
	h "(Anyway...)"
	h "What did you want to talk about?"
end

local q = Question.new{
	"How do you know my name?", myName,
	"Of course. What is it?", haveTime,
	"Sorry, I don't have time right now", dontHaveTime,
	"Do I know you?", doIKnowYou
}
q:ask()

sakura:show("normal")

s.name = "Sakura"
s ("Okay, so my name is " .. s.name .. " and Diego sent me here to tell you about a new visual novel engine he has made from scratch.")
h "From scratch?\n(And who is this Diego anyway?)"
s "Well, he uses some C++ libraries to render images to the screen, play sounds and load files. There is no need to reinvent the wheel."
h "Yet here you are talking about a new visual novel engine when there are plenty out there anyone can use."

sakura:show("serious")

s "That's not my fault, I'm just the messenger."
h "Fair enough."

sakura:show("normal")

s "So, where do I start?"

sakura:show("happy")

s "Oh, I know. Let's talk about text, which is an essential part of visual novels."
h "Okay."
h "(She seems rather excited.)"
s "The size and the position of the area where the text you are reading right now appears are completely customizable for each game, as well as the background."
s "And, as you can see, there is support for non-monospaced fonts, which means that the 'i' character, for instance, is less wide than the 'm' character."
s "This is something you don't see in many Japanese engines."
s "Also, Unicode was invented for a reason, so there is support for characters in other languages too. Look, look!"
h "I'm looking."

sakura:show("laughing")

s "ちゃろー！"

q = Question.new{
	"ちゃろー☆！", 1,
	"ちゃろーですよ", 2,
	"Cha... what?", 3
}
q:ask()

if q.answer == 3 then
	sakura:show("serious")

	s "Charō."
	s "You didn't get that reference? I'm disappointed."
	s "I mean, it's an obscure one, but still."
end

sakura:show("eyes closed")

s "And, of course, you can mix multiple languages in the same line: 日本語."

sakura:show("normal")

s "The only problem is that you need to find a font that has all the characters you need."
h "I see."

s "That was everything I wanted to say about text. Let's move on to the next topic."
s "Hmm... Should we talk about the visual part next?"
h "Sounds good."
s "You probably already noticed that things don't appear or disappear instantly, but that there is a smooth transition instead, right?"
s "Well, doing some testing I discovered something neat you can do with that."
s "I'm going to move out of the way so that you can see it well."
h "Okay."

sakura:hide()
fadeOutMusic(3)

s "Don't look away or you will miss it!"
h "I won't."

hideText()
scene("street evening.png", 3)

h "It's getting late!"
s "Yep. Time sure does fly."

sakura:show("normal")

s "And it will be night soon."

setBackground("street night.png", {type=Transition.dissolve, time=360, block=false})
playMusic("Inspiration.ogg")

s "Okay, let's continue."

hideText()
sakura:moveX(990, 0.3, false)
sleep(0.1)
sakura:setBase("sakura2.png", "sakura2.png", "normal", blockingDissolve)

s "As you can see, fading images in and out is not the only thing you can do, it is also possible to move sprites around the screen."

logo:setPosition(100, 100)
logo:show()
sakura:setBase("sakura3.png", "sakura2.png", "normal", blockingDissolve)

s "And you can display any image anywhere on the screen."

animated1:setPosition(250, 312)
animated1:defineSpriteSheet(89, 13, 7, 60)
animated1:show()

animated2:setPosition(350, 382)
animated2:defineSpriteSheet(89, 13, 7, 30)
animated2:show()

animated3:setPosition(450, 302)
animated3:defineSpriteSheet(89, 13, 7, 120)
animated3:show()

s "And that includes animated sprites thanks to the support for sprite sheets!"

sakura:show("laughing")

s "Look at those octagons spin!"

sakura:setBase("sakura2.png", "sakura2.png", "smiling")

s "Isn't it great?"
h "Y-Yes... of course.\n(They are hexagons though.)"

sakura:show("normal")

s "Anyway, that's all for this part."
s "Let me clean the screen."

hideText()
logo:hide()
animated1:hide()
animated2:hide()
animated3:hide()

sleep(0.3)

sakura:move(Position.center, 0.3, false)
sleep(0.1)
sakura:setBase("sakura1.png", "sakura1.png", "smiling", blockingDissolve)

s "Shall we continue?"

q = Question.new{
	"Yes!", 1,
	"This is getting boring", 2
}

q:ask()

if q.answer == 2 then
	sakura:show("angry")

	s "I'm sorry, but I'm not letting you go anywhere until I finish explaining everything!"
	h "Why?!"
	say "..."
	h "(I guess it can't be helped...)"
	h "Okay, I'll hear you out."
end

sakura:show("normal")

s "Now I'm going to talk about the most important part of the engine."
h "Okay."
s "The part that lets you write a long visual novel and not die trying: the scripting system."
h "That does sound important."

sakura:show("eyes closed")

s "Of course, modifying the engine's code in C++ is not the best solution."
s "Writers don't usually have coding experience, and even if they do, with the amount of text that there is in a visual novel doing that would be a nightmare."
h "I see."

sakura:show("normal")

s "Writing dialogue should be quick and easy."

hideText()
sakura:moveX(990, 0.3, false)
sleep(0.1)
sakura:setBase("sakura2.png", "sakura2.png", "normal", blockingDissolve)

s "Let me show you how the scripts of this engine look."

transitions.showFadeLeft(script1)
sakura:setBase("sakura3.png", "sakura2.png", "normal")

s "The code you see on the screen corresponds to what's going to happen next."

s "First, we need to define our characters as variables."
s "This lets us write their dialogue without having to type their name every time they speak."
h "I see."
s "After that, dialogue is written using the variable followed by the text in quotes."
s "It's that easy."
s "As you can see, once the characters are defined, it doesn't look like programming at all."
s "And to make writers' life easier, if a line is too long to fit in one page, it will be split in two automatically."
s "It is also possible to insert\nline breaks using \\n."

transitions.hideFadeLeft(script1)
sakura:setBase("sakura2.png", "sakura2.png", "normal")

s "Character sprites and their facial expressions are also an essential part of visual novels."

transitions.showFadeLeft(characters)

s "We have a base image of the character without their face and a set of images with each expression they can make."

sakura:setBase("sakura3.png", "sakura2.png", "normal")

s "This allows us to reuse the same expressions with different base images, which is really useful when a character has multiple outfits or when we have multiple base images for the same character with slightly different poses, such as when I extend my arm."

sakura:setBase("sakura2.png", "sakura2.png", "normal")
transitions.hideFadeLeft(characters)

s "Now, let me show you how to change the expression of a character in a script."

transitions.showFadeLeft(script2)

sakura:show("smiling")
s "I'm smiling now."
sakura:show("normal")
s "And this is my neutral expression."
sakura:show("laughing")
s "And now I'm laughing."

sakura:setBase("sakura3.png", "sakura2.png", "normal")

s "And, of course, it is possible to change the speed of the transition or to remove it completely."

transitions.hideFadeLeft(script2)
sakura:setBase("sakura2.png", "sakura2.png", "cheerful")

s "But there is more."
s "Ease of use is crucial, but the language must also be powerful and flexible."
s "Many developers love to add minigames to their novels."
s "And not only that. Maybe you have a sequence of commands that appears multiple times in a script and you want to reduce it to a single line to save some typing, such as a custom transition."
s "Well, guess what!"

sakura:show("happy")

s "Every bit of code you've seen so far is 100% valid in Lua."
s "In fact, the scripts of this engine are written in Lua."
s "Lua is a full programming language, however, its syntax is so simple that those who don't know that won't realize they are writing code."
s "You have already seen how easy it is to write dialogue."

sakura:setBase("sakura3.png", "sakura2.png", "normal")

s "Let me show you some examples of interesting things you can do."

transitions.showFadeLeft(script3)

s "Let's begin with something simple. I'm going to count to five."

for i = 1, 5 do
	s (i)
end

transitions.hideFadeLeft(script3)

s "Maybe that was too simple?"

transitions.showFadeLeft(script4)

s "Let's try something more complex now."
s "Heads or tails?"

-- We will associate a number to each option
q = Question.new{
	"Heads", 0,	-- A value of 0 will mean heads
	"Tails", 1	-- A value of 1 will mean tails
}

-- Ask the player to choose
q:ask()
s "Let's see..."

-- Compare the answer with a randomly generated number between 0 and 1
if q.answer == math.random(0, 1) then
	s "Congratulations! You won!"
else
	s "I'm sorry. Maybe you will have better luck next time."
end

transitions.hideFadeLeft(script4)

s "Let's see a more useful example."
s "There are many games where the player is required to ask a set of questions to a character and is able to decide in which order to ask them."
s "Here is how you can achieve that with this engine."

transitions.showFadeLeft(script5)

-- Choices
local function weather()
	h "Let's talk about the weather."
	s "The weather has been nice today, although it's getting a bit cold now."
end

local function pets()
	h "Are you a cat or a dog person?"
	s "Actually, I like bunnies more."
	h "Oh, I see."
end

local function sociopolitical()
	h "What do you think about the current sociopolitical situation of this country and the whole world?"
	s "Nothing."
	h "Oh, okay."
end

-- Create the question
q = Question.new{
	"Let's talk about the weather", weather,
	"Are you a cat or a dog person?", pets,
	"Let's talk about the sociopolitical situation", sociopolitical
}

-- Remove options after the player selects them
q.removeAfterSelection = true

-- Question loop
while q.count > 0 do
	-- Text of the question
	s "What do you want to talk about?"

	-- Show the choices to the player
	q:ask()
end

hideText()
transitions.hideFadeLeft(script5)
sleep(0.5)

sakura:move(Position.center, 0.3, false)
sleep(0.1)
sakura:setBase("sakura1.png", "sakura1.png", "normal", blockingDissolve)

s "And that's everything I wanted to say about the scripts."

sakura:show("happy")

s "It's such a flexible system that it is possible to implement a Pong minigame. What do you think?"

-- Options
local function great()
	h "That's great!"

	sakura:show("smiling")

	s "I'm glad you like it."

	hideText()
	fadeOutMusic(2)
	scene("black.png", 1)
	sleep(0.5)

	say "After that, we spent some time talking about all kinds of unrelated things."
	hideText()
end

local function dontBelieve()
	sakura:show("normal")

	h "I will believe that when I see it."

	sakura:show("eyes closed")

	s "I was hoping you would say that."

	sakura:show("normal")

	s "Follow me."

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
		"Fine, let's play again", true,
		"That's enough Pong for today", false
	}

	local qLose = Question.new{
		"Think you can win again?", true,
		"That's enough Pong for today", false
	}

	local continue = false

	while not continue do
		if playerWon then
			sleep(0.5)
			sakuraPong:show("nervious")
			sleep(0.3)

			s "I lost?"

			sakuraPong:show("angry")

			s "No way! You must have cheated!"
			s "I want a rematch!"

			qWin:ask()

			if qWin.answer then
				h "Fine, but the result is not going to change."
				s "You won't win this time!"

				hideText()
				sakuraPong:hide()

				playerWon = pong.play()
			else
				h "That's enough Pong for today."

				hideText()
				sakuraPong:hide()
				continue = true
			end
		else
			sleep(0.5)
			sakuraPong:show("eyes closed")
			sleep(0.3)

			s "Heh heh heh."

			sakuraPong:show("normal")

			s "How do you feel after losing to the best Pong player in the world?"

			qLose:ask()

			if qLose.answer then
				h "Think you can win again?"

				sakuraPong:show("eyes closed")

				s "Absolutely."

				hideText()
				sakuraPong:hide()

				playerWon = pong.play()
			else
				h "You won't be so lucky next time, but that's enough for today."

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
	"I will believe that when I see it", dontBelieve,
	"That's great!", great
}
q:ask()

scene("street night.png")

h "It's getting too late."

sakura:show("normal")

s "Yeah."
s "And it's a bit cold here. Should we go to another place and continue talking about the inner workings of the engine?"

-- Options
local function tooLate()
	h "I'm sorry but it's too late."

	sakura:show("eyes closed")

	s "You're right, maybe another day."

	sakura:show("normal")

	s "See you!"
	h "Bye!"
end

local function technical()
	h "Yes, let's keep talking."

	hideText()
	scene("black.png", {type=Transition.imageDissolve, image="wipe right.png", time=1})
	sleep(0.5)
	scene("lookout.png", {type=Transition.imageDissolve, image="wipe right.png", time=1})

	playMusic("Pond.ogg")

	say "In the end we ended up in a lookout from where we could see the entire city."
	say "It's not like it's any less cold up here, but it's where we are."

	sakura:show("normal")

	s "Shall we continue?"
	h "Yes, please."

	sakura:setBase("sakura2.png", "sakura2.png", "normal")

	s "Now I'm going to talk about some technical details."

	sakura:setBase("sakura3.png", "sakura2.png", "normal")

	s "This engine was inspired in part by the Siglus Engine, developed by Visual Art's. In particular, it took inspiration from what can be learned by playing games that use it and studying its config files."
	s "The engine of the Ace Attorney games for the Nintendo 3DS was also a big reference."

	sakura:setBase("sakura2.png", "sakura2.png", "normal")

	s "As these games use high-quality 3D models with limited RAM, it's easy to learn how they handle the loading of resources."
	s "Both engines seem to use a similar technique, which is the same one used by this engine."

	sakura:setBase("sakura3.png", "sakura2.png", "normal")

	s "Resources are loaded to memory the first time they are needed."
	s "After that, they will remain in memory until the total size of the currently loaded resources exceeds the limit set in the config file."
	s "When that limit is reached, the least recently used resources will be unloaded until there is enough room for the next resource that needs to be loaded."
	s "It is also possible to preload part of the resources needed for a script at the beginning of it, so that they are already in memory when they are needed, reducing frame rate drops during gameplay."

	sakura:setBase("sakura1.png", "sakura1.png", "smiling")

	s "And that's it."
	s "I hope you found this interesting."
	s "Thanks for your attention."
	s "See you!"
	h "Bye!"
end

q = Question.new{
	"No, it's gotten too late", tooLate,
	"Yes, that sounds interesting", technical
}
q:ask()

badEnd()