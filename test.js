function scrollToElm(container, elm, duration){
  var pos = getRelativePos(elm);
  scrollTo( container, pos.top , 2);  // duration in seconds
}

function getRelativePos(elm){
  var pPos = elm.parentNode.getBoundingClientRect(), // parent pos
    cPos = elm.getBoundingClientRect(), // target pos
    pos = {};
  
  pos.top    = cPos.top    - pPos.top + elm.parentNode.scrollTop,
    pos.right  = cPos.right  - pPos.right,
    pos.bottom = cPos.bottom - pPos.bottom,
    pos.left   = cPos.left   - pPos.left;
  
  return pos;
}

function scrollTo(element, to, duration, onDone) {
  var start = element.scrollTop,
    change = to - start,
    startTime = performance.now(),
    val, now, elapsed, t;
  
  function animateScroll(){
    now = performance.now();
    elapsed = (now - startTime)/1000;
    t = (elapsed/duration);
    
    element.scrollTop = start + change * easeInOutQuad(t);
    
    if( t < 1 )
      window.requestAnimationFrame(animateScroll);
    else
      onDone && onDone();
  };
  
  animateScroll();
}

function easeInOutQuad(t){ return t<.5 ? 2*t*t : -1+(4-2*t)*t };

scrollToElm(document.getElementById('participant-timeline'), document.getElementById('poll-tl-8'), 1);


var listElement = [];
for(const i of $(".timeline-content .title")){
  console.log(i.innerText + i.getAttribute('type'));
  element = i.innerHTML + ' (' + i.getAttribute('type') + ')';
  listElement.push(element)
}







