extends Node2D

class_name Grid

const Cell = preload("res://scripts/Cell.gd")

var grid := []
var _rows: int
var _columns: int

func _init(row_count, column_count):
    _rows = row_count
    _columns = column_count
    
    prepare_grid()
    configure_cells()
    
func prepare_grid():
    grid = []
    
    for r in range(_rows):
        var row = []
        for c in range(_columns):
            row.append(Cell.new(r, c))
        grid.append(row)

func configure_cells():
    # Sets cell neighbors
    for r in range(_rows):
        for c in range(_columns):
            var cell = grid[r][c]
            cell.north = get_cell(r - 1, c)
            cell.south = get_cell(r + 1, c)
            cell.east = get_cell(r, c + 1)
            cell.west = get_cell(r, c - 1)

func get_cell(row, column):
    if out_of_bounds(row, column):
        return null
    else:
        return grid[row][column]

func get_random_cell():
    var row_index = randi()%_rows
    var column_index = randi()%_columns
    var cell = grid[row_index][column_index]
    return cell

func deadends():
    # Returns list of all deadends
    var d = []
    for r in range(_rows):
        for c in range(_columns):
            var cell = grid[r][c]
            if len(cell.links) == 1:
                d.append(cell)
    return d

func out_of_bounds(row, column):
    return row < 0 or row > _rows - 1 or column < 0 or column > _columns - 1
    
func size():
    return _rows * _columns

func get_open_cells():
    pass
    
func braid(p=1.0):
    # Removes all deadends in the grid
    # By default p is set to 1.0 and removes 100% of the deadends. 
    # If it's set to, for instance, 0.5, it will randomly remove about 50% of the deadends.
    
    var d = deadends()
    d.shuffle()
    for cell in d:
        if len(cell.links) != 1: continue

        if randf() > p:
            # Skip the deadend randomly
            continue
        
        var neighbors = []

        for neighbor in cell.neighbors():
            if not cell.is_linked(neighbor):
                neighbors.append(neighbor)

        var best: Cell
        
        for neighbor in neighbors:
            if len(neighbor.links) == 1:
                best = neighbor
                break

        if not best:
            best = neighbors[randi()%len(neighbors)]
        
        cell.link(best)

