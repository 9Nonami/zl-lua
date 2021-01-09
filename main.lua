CELL_SIZE = 30
WINDOW_WIDTH = 300
WINDOW_HEIGHT = 300

local p = require("player")

maps = {}
currentmap = {}

local sprites = {}
local grass = 0
local wall = 1
local entrance = 9
local entrance2 = 8

BLOCKS = {
	[wall] = true
}

function love.load()
	sprites[grass] = love.graphics.newImage("grass.png")
	sprites[wall] = love.graphics.newImage("wall.png")
	sprites[entrance] = love.graphics.newImage("entrance.png")
	sprites[entrance2] = love.graphics.newImage("entrance2.png")

	createmaps()
end

function createmaps()
	maps[1] = {
		map = {
			{1, 8, 8, 1, 1, 1, 1, 1, 1, 1},
			{1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
			{1, 0, 0, 1, 1, 0, 0, 0, 0, 1},
			{1, 0, 0, 0, 1, 0, 0, 0, 0, 1},
			{1, 0, 0, 0, 1, 0, 0, 0, 0, 1},
			{1, 0, 0, 1, 1, 1, 0, 0, 0, 1},
			{1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
			{1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
			{1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
			{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
		},
		entrances = {
			[2] = 2,
			[3] = 2
		}
	}
	maps[2] = {
		map = {
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
		}
	}
	currentmap = maps[1]
end

function love.update(dt)
	p:update(currentmap)
end

function love.draw()
	for y = 0, #currentmap.map-1 do
		for x = 0, #currentmap.map[y+1]-1 do
			love.graphics.draw(sprites[currentmap.map[y+1][x+1]], CELL_SIZE*x, CELL_SIZE*y)
		end
	end
	p:draw()
	love.graphics.reset()
end