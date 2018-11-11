local circleX,circleY
local bulletz
local again = 0
local xCoord, yCoord
local volume = 0.2
local hit = 0
local timer = 6000
local gameOverTimer = 8000
function love.load()
	player = {}
	player.x = 0
	player.bullets = {}
	player.fire = function()
		bullet = {}
		bullet.x = player.x
		bullet.y = 400
		table.insert(player.bullets, bullet)
	end
	love.graphics.setBackgroundColor(206,206,206)
	pic = love.graphics.newImage("yeah.jpg")
	
	pic2 = love.graphics.newImage("fuck.jpg")
	pic3 = love.graphics.newImage("yeah2.jpg")
	pic4 = love.graphics.newImage("yeahboi.jpg")
	yeahred = love.graphics.newImage("yeahred.jpg")
	yeah2red = love.graphics.newImage("yeah2red.jpg")
	yeahboired = love.graphics.newImage("yeahboired.jpg")
	enemy = love.graphics.newImage("enemy.png")
	
	music = love.audio.newSource("Fuck_This_Shit_Im_Out_10min.mp3")
	
	if (again < 1) then 
		love.audio.setVolume(volume)
		music:play() 
	end
	bulletz = 500
	xCoord = math.random(100,love.graphics.getWidth())
	yCoord = 20
	circleX = love.graphics.getWidth()/2
	circleY = love.graphics.getHeight()/2
end
	
function love.draw()
	if(love.keyboard.isDown('d')) then
		if(bulletz >0) then
			love.graphics.draw(pic, player.x, circleY)
		else
			love.graphics.draw(yeahred, player.x, circleY)
		end
	elseif(love.keyboard.isDown('a')) then
		if(bulletz >0) then
			love.graphics.draw(pic3, player.x, circleY)
		else
			love.graphics.draw(yeah2red, player.x, circleY)
		end
	else
		if(bulletz >0) then
			love.graphics.draw(pic4, player.x, circleY)
		else
			love.graphics.draw(yeahboired, player.x, circleY)
		end
	end
	if bulletz >0 then
		for _,b in pairs(player.bullets) do
			
			--love.graphics.circle("fill",b.x,b.y,10,100)
			love.graphics.draw(pic2,b.x,b.y)
			if(b.x <= xCoord+20 and b.x >= xCoord-20 and b.y <= yCoord-20 and b.y <= yCoord+20) then
				xCoord = math.random(1,love.graphics.getWidth()-50)
				--yCoord = math.random(100,love.graphics.getHeight()/2)
				volume = volume + 0.3
				love.audio.setVolume(volume)
				hit = hit + 1 
			end
				
		end
		love.graphics.print("You have " .. bulletz .. " fucks left to give", 0, 0)
		love.graphics.print("You gave " .. hit .. " fuck(s)", 0, 10)
		love.graphics.print("You've got: " .. timer .. " seconds", 0, 20)
	
	else
		love.graphics.setBackgroundColor(255,0,0)
		love.graphics.print("Sorry mate, you have zero fucks to give", 530, 0)
		love.graphics.print("You gave " .. hit .. " fucks", 530, 10)
		love.graphics.print("Press r for a new game", 600, 20)
	end
	if timer <= 0 then 
		love.graphics.print("Game over dude", 300, 300)
	end
	love.graphics.draw(enemy,xCoord,yCoord)
end

function love.update(dt)
	gameOverTimer = gameOverTimer -1
	if timer >= 1 then
		timer = timer - 1
		if(love.keyboard.isDown('a')) then
			player.x = player.x -10
			
		end
		if(love.keyboard.isDown('d')) then
			player.x = player.x +10
		end
		
		if(love.keyboard.isDown("space")) then
			player.fire()
			bulletz = bulletz -1
		end
		if(player.x >= love.graphics.getWidth()) then
			player.x = 1
		end
		if(player.x <= 0 ) then
			player.x = love.graphics.getWidth()-100
		end
		
		for i,b in ipairs(player.bullets) do
			if b.y < -10 then
				table.remove(player.bullets, i)
			end
			b.y = b.y - 10
		end
	end
	
	
	if love.keyboard.isDown("r") and bulletz <= 0 or timer <= 0 then
		
		
			again = 1
			hit = 0
			timer = 6000
			gameOverTimer = 8000
			love.load()
		
		
			
		
	end
end