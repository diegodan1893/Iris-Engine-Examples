function badEnd()
	hideText()
	fadeOutMusic(2)
	scene("black.png", 2)
	sleep(1)
	openScript("_start.lua")
end

lang = "es/"

--openScript("demo.lua")

dofile("assets/scripts/pong/pong.lua")
sleep(2)
pong.init()
pong.tutorial()

while true do
pong.play()
end