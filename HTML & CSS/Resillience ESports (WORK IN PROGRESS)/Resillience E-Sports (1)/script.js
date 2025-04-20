const navbar = document.getElementsByClassName("navbar");
const video = document.getElementsByClassName("container");

document.addEventListener("scroll", navbarDetect)

function navbarDetect(){
if(window.scrollY > video[0].offsetHeight){navbar[0].style.backgroundColor = "black"} else {navbar[0].style.backgroundColor = "transparent"}
}
