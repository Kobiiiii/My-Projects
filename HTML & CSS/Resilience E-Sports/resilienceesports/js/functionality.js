// Small navbar
// As this navbar only works for smaller screens, I will be using a media query check for screen widths.
let button = document.getElementById("mini")
let navbar = document.getElementById("navbar")
let nuer = window.matchMedia('(width <= 1000px)')
let on = false

function open(){
    if(on == false){
        navbar.style.height = "260px" 
        button.innerHTML = "x"
        button.style.fontWeight = "100"
        on = true
    } else {close()}
}

function close() {
    if(on == true){
        navbar.style.height = "60px"
        button.innerHTML = "≡"
        on = false
    }

}

function check() {
    if(nuer.matches == false && navbar.style.height >= "260px") {
        navbar.style.height = "60px"
    }
}

button.addEventListener("click", open)
window.addEventListener("resize", check)


// All sliders
// How do sliders work:

// there are 3 things to consider, the position of the slider, the mouse and where it is.
// e.clientX - startX is also known as delta that is the change in something.

// essentialy a slider is where the element is currently as it's idle and adding it by the distance
// that we apply onto the current slider position to give it a new position.

// CurrentX is responsible for making sure after we change the position using delta then it changes the 
// new position.

// Made a state machine to know if the slider is held or not.
// Change the slider position by adding the distance (like picking up a ball and moving it).
// Let go of the slider and log in the new new current position.

const slider = document.getElementsByClassName("slider")[0];
let sliderChild;



let held = false;
let startX = 0;
let currentX = 0; // the committed position
let deltaX = 0;   // temporary drag distance

slider.addEventListener("mousedown", (e) => {
    held = true;
    startX = e.clientX;
    findSliderMax()
});

document.addEventListener("mousemove", (e) => {
    if (held) {
        deltaX = e.clientX - startX;
        slider.style.transform = `translateX(${Math.max(Math.min(currentX + deltaX, 0), findSliderMax())}px)`;
    }
});

document.addEventListener("mouseup", (e) => {
    if (held) {
        held = false;
        currentX = Math.max(Math.min(currentX + deltaX, 0), findSliderMax()); // commit position
        deltaX = 0;
    }
});

slider.addEventListener("mouseleave", () => { held = false; });

function findSliderMax() {
    sliderChild = slider.children
    let childWidth = slider.children[0]

    for(i = 0; i < sliderChild.length; i++) {
        if( i == sliderChild.length - 1) {
            let reduced = i-0.5;
            return childWidth.clientWidth * reduced * -1
        }
    }
}
// Button sliders
const cards = document.getElementsByClassName("shopCard")
const right = document.getElementsByClassName("right")[0]
const left = document.getElementsByClassName("left")[0]

right.addEventListener("click", () => {slider.style.transform += `translateX(${Math.max(-slider.clientWidth, -400)}px)`})
left.addEventListener("click", () => {slider.style.transform += `translateX(${slider.clientWidth}px)`})
slider.style.transform = ``