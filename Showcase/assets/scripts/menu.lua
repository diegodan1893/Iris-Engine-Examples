-- Main menu

-- Import useful transitions
dofile("assets/scripts/transitions.lua")

-- Defintion of sprites and buttons
local logo = Sprite.new("logo.png", 50)
logo:setPosition(0, 50)

local start = Button.new(lang .. "start button.png", 50)
start:setPosition(0, 471)
start.onClick = function()
	fadeOutMusic(2)
	scene("black.png", 2)
	sleep(1)
	scene("white.png", 1)
	sleep(1)
	openScript(lang .. "demo.lua")
end

local exit = Button.new(lang .. "exit button.png", 50)
exit:setPosition(0, 552)
exit.onClick = function()
	fadeOutMusic(2)
	scene("black.png", 2)
	exitGame()
end

-- Menu script
scene("white.png", 1)
playMusic("Brothers Unite.ogg")
sleep(1)
scene("menu.png", 2)

transitions.showFadeRight(logo, nil, true, 40, 1.5)
start:show({type=Transition.fade, time=1.5, block=false})
sleep(0.1)
exit:show({type=Transition.fade, time=1.5, block=false})