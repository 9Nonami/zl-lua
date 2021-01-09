return {
	x = 30,
	y = 30,
	w = 30,
	h = 30,
	speed = 2,

	update = function(self, _map)
		local up = love.keyboard.isDown("up")
		local down = love.keyboard.isDown("down")
		local left = love.keyboard.isDown("left")
		local right = love.keyboard.isDown("right")

		if self:isoutofmap(up, down, left, right) then
			local currentx = math.floor((self.x + (self.w/2)) / CELL_SIZE)
			local currenty = math.floor((self.y + (self.h/2)) / CELL_SIZE)
			local currentid = (currentx + (currenty * (WINDOW_WIDTH/CELL_SIZE)) + 1)

			currentmap = maps[_map.entrances[currentid]]
			self.x = 150
			self.y = 150
		else
			if up and not self:upcollide(_map) then
				self.y = self.y - self.speed
			end
			if down and not self:downcollide(_map) then
				self.y = self.y + self.speed
			end
			if left and not self:leftcollide(_map) then
				self.x = self.x - self.speed
			end
			if right and not self:rightcollide(_map) then
				self.x = self.x + self.speed
			end
		end
	end,

	--[[
		A - B
		|   |
		C - D
	]]--

	upcollide = function(self, _map)
		local ax = math.floor(self.x / CELL_SIZE)
		local ay = math.floor((self.y - self.speed) / CELL_SIZE)

		local bx = math.floor((self.x + self.w - 1) / CELL_SIZE)
		local by = math.floor((self.y - self.speed) / CELL_SIZE)

		return (BLOCKS[_map.map[ay+1][ax+1]] or BLOCKS[_map.map[by+1][bx+1]])
	end,

	downcollide = function(self, _map)
		local cx = math.floor(self.x / CELL_SIZE)
		local cy = math.floor((self.y + self.h - 1 + self.speed) / CELL_SIZE)

		local dx = math.floor((self.x + self.w - 1) / CELL_SIZE)
		local dy = math.floor((self.y + self.h - 1 + self.speed) / CELL_SIZE)

		return (BLOCKS[_map.map[cy+1][cx+1]] or BLOCKS[_map.map[dy+1][dx+1]])
	end,

	leftcollide = function(self, _map)
		local ax = math.floor((self.x - self.speed) / CELL_SIZE)
		local ay = math.floor(self.y / CELL_SIZE)

		local cx = math.floor((self.x - self.speed) / CELL_SIZE)
		local cy = math.floor((self.y + self.h - 1) / CELL_SIZE)

		return (BLOCKS[_map.map[ay+1][ax+1]] or BLOCKS[_map.map[cy+1][cx+1]])
	end,

	rightcollide = function(self, _map)
		local bx = math.floor((self.x + self.w - 1 + self.speed) / CELL_SIZE)
		local by = math.floor(self.y / CELL_SIZE)

		local dx = math.floor((self.x + self.w - 1 + self.speed) / CELL_SIZE)
		local dy = math.floor((self.y + self.h - 1) / CELL_SIZE)

		return (BLOCKS[_map.map[by+1][bx+1]] or BLOCKS[_map.map[dy+1][dx+1]])
	end,

	isoutofmap = function(self, up, down, left, right)
		if up and self.y - self.speed < 0 then
			return true
		end --ok

		if down and self.y + self.h - 1 + self.speed > WINDOW_HEIGHT - 1 then
			return true
		end --ok

		if left and self.x - self.speed < 0 then
			return true	
		end --ok

		if right and self.x + self.w - 1 + self.speed > WINDOW_WIDTH - 1 then
			return true
		end --ok

		return false
	end,

	draw = function(self)
		love.graphics.setColor(1, 0, 1)
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

		--love.graphics.setColor(0, 0, 0)
		--love.graphics.print(self.currentid, self.x + 5, self.y + 10)
	end
}