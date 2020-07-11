extends Node2D

const Grid = preload("res://scripts/Grid.gd")
const BinaryTree = preload("res://scripts/BinaryTree.gd")

var grid := Grid.new(8,15)
var maze_algo := BinaryTree.new()

onready var tilemap = $TileMap

func _ready():
    # Initialize random seed
    randomize()
    
    # Generate the maze
    maze_algo.run(grid)
    grid.braid()
    
    update_tilemap()
    
func update_tilemap():
    # Updates the tilemap to match the grid
    for r in range(grid._rows):
        for c in range(grid._columns):
            var cell = grid.get_cell(r, c)
            
            if cell:
                var tile_r = grid_to_tile(r)
                var tile_c = grid_to_tile(c)
                
                var tile_i = 47
                
                # northwest
                tilemap.set_cell(tile_c-1, tile_r-1, tile_i)
                # northeast
                tilemap.set_cell(tile_c+1, tile_r-1, tile_i)
                # southwest
                tilemap.set_cell(tile_c+1, tile_r+1, tile_i)
                # southeast
                tilemap.set_cell(tile_c-1, tile_r+1, tile_i)

                if not cell.is_linked(cell.north):
                    tilemap.set_cell(tile_c, tile_r-1, tile_i)
                if not cell.is_linked(cell.south):
                    tilemap.set_cell(tile_c, tile_r+1, tile_i)
                if not cell.is_linked(cell.east):
                    tilemap.set_cell(tile_c+1, tile_r, tile_i)
                if not cell.is_linked(cell.west):
                    tilemap.set_cell(tile_c-1, tile_r, tile_i)
                    
    tilemap.update_bitmask_region()

func grid_to_tile(grid_coord):
    return grid_coord * 2 + 1
            
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
