// Generated by CoffeeScript 1.7.1
(function() {
  var PSD, nextState, prepDot, resetStates;

  PSD = Framer.Importer.load("imported/dots");

  tools.storeOriginal(PSD);

  PSD.dotActive.states.animationOptions = {
    curve: "bezier-curve",
    curveOptions: "ease-in-out",
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

  PSD.dotActive.on(Events.AnimationEnd, function() {
    if (PSD.dotActive.states.current === "dot3") {
      return PSD.dotActive.states["switch"]("dot1");
    } else if (PSD.dotActive.states.current === "dot1") {
      return PSD.dotActive.states["switch"]("dot2");
    } else if (PSD.dotActive.states.current === "dot2") {
      return PSD.dotActive.states["switch"]("dot3");
    }
  });

  PSD.dotActive.states["switch"]("dot1");

  PSD.dotInside.states.add({
    top: {
      y: PSD.dotInside.originalFrame.y + 100
    },
    bottom: {
      y: PSD.dotInside.originalFrame.y - 100
    }
  });

  PSD.dotInside.states.animationOptions = {
    curve: "bezier-curve",
    curveOptions: "ease-in-out",
    time: 0.5
  };

  PSD.dotInside.on(Events.AnimationEnd, function() {
    if (PSD.dotInside.states.current === "top") {
      return PSD.dotInside.states["switch"]("bottom");
    } else {
      return PSD.dotInside.states["switch"]("top");
    }
  });

  PSD.dotInside.states["switch"]("top");

  PSD.dotScale.states.add({
    big: {
      scale: 1.5
    },
    small: {
      scale: 0.5
    }
  });

  PSD.dotScale.states.animationOptions = {
    curve: 'spring(150,20,0)'
  };

  PSD.dotScale.on(Events.AnimationEnd, function() {
    if (PSD.dotScale.states.current === "big") {
      return PSD.dotScale.states["switch"]("small");
    } else {
      return PSD.dotScale.states["switch"]("big");
    }
  });

  PSD.dotScale.states["switch"]("small");

}).call(this);
