--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  Dimensions and character speed constants
  ]]
  
--Based on the resolution of the gameboy advance
VIRTUAL_WIDTH = 240
VIRTUAL_HEIGHT = 160

--So the window size is appropriately scaled to modern screens
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

TILE_SIZE = 16

--Player and monster walking speed
ENTITY_WALKSPEED = 60

--Map position
MAP_X = 16
MAP_Y = 16

--Constants for the map dimensions
MAP_WIDTH = VIRTUAL_WIDTH / TILE_SIZE - 3 --12
MAP_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE - 1 -- 9 Leaves space at the top of the screen for the heart ui

--UI heart display, y position
HEART_Y = 0

--Door positions
NORTH_DOOR_X = 112
NORTH_DOOR_Y = 16

EAST_DOOR_X = 192
EAST_DOOR_Y = 80

SOUTH_DOOR_X = 112
SOUTH_DOOR_Y = 144

WEST_DOOR_X = 16
WEST_DOOR_Y = 80

--Enter room positions
ENTRY_NORTH_X = 112
ENTRY_NORTH_Y = 32

ENTRY_EAST_X = 176
ENTRY_EAST_Y = 80

ENTRY_SOUTH_X = 112
ENTRY_SOUTH_Y = 128

ENTRY_WEST_X = 32
ENTRY_WEST_Y = 80

--Tile IDs
--Corner tiles
TILE_TOP_LEFT_CORNER = 1
TILE_TOP_RIGHT_CORNER = 5
TILE_BOTTOM_LEFT_CORNER = 21
TILE_BOTTOM_RIGHT_CORNER = 25
--Floor tiles
--1D array arranged to give the dimensions of the floor
TILE_FLOOR = 
{7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
7, 7, 7, 7, 7, 7, 7, 7, 7, 7}
--Wall tiles
TILE_TOP_WALLS = {2, 3, 3, 3, 3, 3, 3, 3, 3, 4}
TILE_BOTTOM_WALLS = {22, 23, 23, 23, 23, 23, 23, 23, 23, 24}
TILE_LEFT_WALLS = {6, 11, 11, 11, 11, 11, 16}
TILE_RIGHT_WALLS = {10, 15, 15, 15, 15, 15, 20}
