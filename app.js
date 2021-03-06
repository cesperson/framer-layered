// Generated by CoffeeScript 1.7.1
(function() {
  var PSD, nextState, prepDot, resetStates;

  PSD = Framer.Importer.load("imported/dots");

  tools.storeOriginal(PSD);

  PSD.dotActive.states.animationOptions = {
    curve: "ease-both",
    time: 1
  };

  resetStates = function() {
    return PSD.dotActive.states.add({
      dot1: {
        x: PSD.dot1.x,
        y: PSD.dot1.y
      },
      dot2: {
        x: PSD.dot2.x,
        y: PSD.dot2.y
      },
      dot3: {
        x: PSD.dot3.x,
        y: PSD.dot3.y
      }
    });
  };

  prepDot = function(view) {
    view.draggable.enabled = true;
    view.on(Events.DragMove, resetStates);
    view.on(Events.DragStart, function() {
      return view.opacity = 1;
    });
    view.on(Events.DragEnd, function() {
      return view.opacity = 0.1;
    });
    return view.opacity = 0.1;
  };

  prepDot(PSD.dot1);

  prepDot(PSD.dot2);

  prepDot(PSD.dot3);

  resetStates();

  nextState = function(view) {
    if (view.states.current === "default" || view.states.current === "dot3") {
      return PSD.dotActive.states["switch"]("dot1");
    } else if (view.states.current === "dot1") {
      return PSD.dotActive.states["switch"]("dot2");
    } else if (view.states.current === "dot2") {
      return PSD.dotActive.states["switch"]("dot3");
    }
  };

  setInterval(function() {
    return nextState(PSD.dotActive);
  }, 1000);

  PSD.dotInside.states.animationOptions = {
    curve: "ease-out",
    time: 0.15
  };

  PSD.dotInside.states.add({
    top: {
      y: PSD.dotInside.originalFrame.y + 100,
      scale: 0.75
    },
    bottom: {
      y: PSD.dotInside.originalFrame.y - 100,
      scale: 1.25
    }
  });

  setInterval(function() {
    if (PSD.dotInside.states.current === "top") {
      return PSD.dotInside.states["switch"]("bottom");
    } else {
      return PSD.dotInside.states["switch"]("top");
    }
  }, 300);

}).call(this);
