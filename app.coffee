PSD = Framer.Importer.load("imported/dots")

# Add original frame information to each layer
tools.storeOriginal(PSD)

# Add blue background
#background = new BackgroundLayer backgroundColor:"rgba(77, 208, 225, 1.00)"

## Fade from black ## --------------------------------------------------------------------------------------------------
#PSD.dots.brightness = 0
#PSD.container.animate
#  properties:
#    brightness: 100
#  curve: "linear"
#  time: 0.5

#PSD.dotActive.opacity = 0.5

PSD.dotActive.states.animationOptions =
#  curve: "spring(150, 22, 1)"
  curve: "ease-both"
  time: 1


resetStates = ->
  PSD.dotActive.states.add
    dot1:
      x: PSD.dot1.x
      y: PSD.dot1.y
    dot2:
      x: PSD.dot2.x
      y: PSD.dot2.y
    dot3:
      x: PSD.dot3.x
      y: PSD.dot3.y

prepDot = (view) ->
  view.draggable.enabled = true
  view.on Events.DragMove, resetStates
  view.on Events.DragStart, ->
    view.opacity = 1
  view.on Events.DragEnd, ->
    view.opacity = 0.1
  view.opacity = 0.1

prepDot PSD.dot1
prepDot PSD.dot2
prepDot PSD.dot3

resetStates()

#PSD.dotActive.states.switch "dot1"
#PSD.dotActive.states.switch "dot2"
#PSD.dotActive.states.switch "dot3"


nextState = (view) ->
  if view.states.current == "default" || view.states.current == "dot3"
    PSD.dotActive.states.switch "dot1"
  else if view.states.current == "dot1"
    PSD.dotActive.states.switch "dot2"
  else if view.states.current == "dot2"
    PSD.dotActive.states.switch "dot3"

#run = ->
#  nextState PSD.dotActive
#
#run
#utils.delay 1, ->

setInterval ->
  nextState PSD.dotActive
, 1000


# Set states
PSD.dotInside.states.animationOptions =
#  curve: "spring(150, 50, 10)"
  curve: "ease-out"
  time: 0.15

PSD.dotInside.states.add
  top:
    y: PSD.dotInside.originalFrame.y + 100
    scale: 0.5
  bottom:
    y: PSD.dotInside.originalFrame.y - 100
    scale: 2

setInterval ->
  if PSD.dotInside.states.current == "top"
    PSD.dotInside.states.switch "bottom"
  else
    PSD.dotInside.states.switch "top"
, 300


