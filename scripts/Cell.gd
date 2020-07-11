extends Node2D

class_name Cell

var _row: int
var _column: int
var links: Dictionary

var north: Cell
var south: Cell
var east: Cell
var west: Cell

func _init(row: int, column: int):
    _row = row
    _column = column
    links = {}

func link(cell: Cell, bidi=true):
    links[cell] = true
    if bidi: cell.link(self, false)
    return self

func unlink(cell: Cell, bidi=true):
    links.erase(cell)
    if bidi: cell.unlink(self, false)
    return self

func is_linked(cell):
    return cell in links

func neighbors():
    var n = []
    
    for neighbor in [north, south, east, west]:
        if neighbor:
            n.append(neighbor)

    return n
