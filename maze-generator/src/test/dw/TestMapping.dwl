%dw 2.0
output application/json

import primsMaze, rectangleCanvas from MazeGenerator
---
primsMaze(rectangleCanvas({x: 21, y: 21}))