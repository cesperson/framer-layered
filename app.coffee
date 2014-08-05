PSD = Framer.Importer.load("imported/dots")

# Add original frame information to each layer
tools.storeOriginal(PSD)

## Fade from black ## --------------------------------------------------------------------------------------------------

PSD.dotActive.states.animationOptions =
  curve: "bezier-curve"
  curveOptions: "ease-in-out"
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

nextState = (view) ->
  if view.states.current == "default" || view.states.current == "dot3"
    PSD.dotActive.states.switch "dot1"
  else if view.states.current == "dot1"
    PSD.dotActive.states.switch "dot2"
  else if view.states.current == "dot2"
    PSD.dotActive.states.switch "dot3"

PSD.dotActive.on Events.AnimationEnd, ->
  if PSD.dotActive.states.current == "dot3"
    PSD.dotActive.states.switch "dot1"
  else if PSD.dotActive.states.current == "dot1"
    PSD.dotActive.states.switch "dot2"
  else if PSD.dotActive.states.current == "dot2"
    PSD.dotActive.states.switch "dot3"

PSD.dotActive.states.switch "dot1"

## Vertical ## ------------------------------------------------------

PSD.distancedot2.draggable.enabled = true
# Disable horizontal dragging
PSD.distancedot2.draggable.speedX = 0

verticalOffset = PSD.distancedot1.y - PSD.distancedot2.y

setVerticalOffset = ->
  verticalOffset = PSD.distancedot1.y - PSD.distancedot2.y
  console.log verticalOffset
  PSD.dotInside.states.add
    top:
      y: PSD.dotInside.originalFrame.y + verticalOffset
    bottom:
      y: PSD.dotInside.originalFrame.y - verticalOffset

  PSD.distancedotbackforth.states.add
    top:
      y: PSD.distancedot2.y
    bottom:
      y: PSD.distancedot1.y + 21

PSD.distancedot2.on Events.DragEnd, setVerticalOffset

setVerticalOffset()

# Set up vertical movement
setupVertical = (view) ->
  view.states.add
    top:
      y: view.originalFrame.y + verticalOffset
    bottom:
      y: view.originalFrame.y - verticalOffset

  view.states.animationOptions =
    curve: "bezier-curve"
    curveOptions: "ease-in-out"
    time: 0.5

  view.on Events.AnimationEnd, ->
    if view.states.current == "top"
      view.states.switch "bottom"
    else
      view.states.switch "top"

  view.states.switch "top"

setupVertical(PSD.dotInside)

setupVertical2 = (view) ->
  view.states.add
    top:
      y: PSD.distancedot2.y
    bottom:
      y: PSD.distancedot1.y

  view.states.animationOptions =
    curve: "bezier-curve"
    curveOptions: "ease-in-out"
    time: 0.5

  view.on Events.AnimationEnd, ->
    if view.states.current == "top"
      view.states.switch "bottom"
    else
      view.states.switch "top"

  view.states.switch "top"

setupVertical2(PSD.distancedotbackforth)



## Scaling ## -----------------------------------------------
PSD.dotScale.states.add
  big:
    scale: 1.5
  small:
    scale: 0.5

PSD.dotScale.states.animationOptions =
  curve:'spring(150,20,0)'

PSD.dotScale.on Events.AnimationEnd, ->
  if PSD.dotScale.states.current == "big"
    PSD.dotScale.states.switch "small"
  else
    PSD.dotScale.states.switch "big"

#PSD.dotScale.states.switch "small"

