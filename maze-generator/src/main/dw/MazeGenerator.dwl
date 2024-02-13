%dw 2.0
import * from dw::core::Arrays

type Point = {x: Number, y: Number}
type Canvas = Array<Point>
type Dimensions = Point

type Edge = {p1: Point, p2: Point}

fun rectangleCanvas(d: Dimensions): Canvas =
    (1 to d.y) as Array flatMap (y) ->
        (1 to d.x) map (x) -> {x: x, y: y}

fun isNeighbor(p1: Point, p2: Point) =
    (p1.x == p2.x and (p1.y - p2.y == 1 or p2.y - p1.y == 1)) // vertical neighbor
    or
    (p1.y == p2.y and (p1.x - p2.x == 1 or p2.x - p1.x == 1)) // horizontal neighbor

fun findNeighbors(c: Canvas, p: Point): Array<Edge> = do {
    var nextPoints = c filter (p2) -> p isNeighbor p2
    ---
    nextPoints map (neighbor) -> {p1: p, p2: neighbor}
}

fun contains(e: Edge, p: Point): Boolean =
    e.p1 == p or e.p2 == p

fun primsMaze(c: Canvas): Array<Edge> = do {
    var x = 0
    fun primsMaze(maze: Array<Edge>, nextEdges: Array<Edge>): Array<Edge> =
        if (isEmpty(nextEdges)) maze
        else do {
            // TODO: not prims until we do the min weight
            var nextEdge = nextEdges[randomInt(sizeOf(nextEdges))] // randomized walk strategy
            var isCycle = maze some (edge) -> edge contains nextEdge.p2
            var nextMaze = if (isCycle) maze else maze << nextEdge
            var newEdges = if (isCycle) [] else c findNeighbors nextEdge.p2
            ---
            primsMaze(nextMaze, nextEdges - nextEdge ++ newEdges)
        }
    ---
    primsMaze([], c findNeighbors c[0])
}
