extends Node

class_name BinaryTree

const Cell = preload("res://scripts/Cell.gd")


func run(grid):
    for row in grid.grid:
        for cell in row:
            var neighbors := []
            if cell.north: 
                neighbors.append(cell.north)
            if cell.east: 
                neighbors.append(cell.east)
            
            if neighbors:
                var index: int = randi() % len(neighbors)
                var neighbor: Cell = neighbors[index]
            
                if neighbor: 
                    cell.link(neighbor)
