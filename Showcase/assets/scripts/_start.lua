function badEnd()
	hideText()
	fadeOutMusic(2)
	scene("black.png", 2)
	sleep(1)
	openScript("_start.lua")
end

lang = "es/"

openScript("demo.lua")