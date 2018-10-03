-- Useful global functions
function badEnd()
	hideText()
	fadeOutMusic(2)
	scene("black.png", 2)
	sleep(1)
	openScript("menu.lua")
end

-- Language selector
local q = Question.new{
	"English", "en/",
	"Español", "es/"
}

-- Ask the player to select a language
q:ask()

-- Save the selected language in a global variable
-- so that all scripts can check it
lang = q.answer

sleep(1)
openScript("menu.lua")