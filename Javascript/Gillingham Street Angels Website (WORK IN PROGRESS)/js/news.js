function Navbar() {
    // Gethering navbar.
    // JSON.parse means to turn the string into data that can be executed by code.
    const navbar = document.getElementById("navbar");
    const navbarBtns = JSON.parse(navbar.dataset.navbtns);

    navbarBtns.forEach((element)=> {  

    let button = document.createElement("button"); 
    button.innerHTML = element; 
    navbar.appendChild(button);

    button.addEventListener("click", function(){window.location.href = `${button.innerHTML}.html`.toLowerCase()})

    })

    
}

function TopNavBar() {

    // The top navbar is the one with Gillingham street angels on it.
    // Slightly different layout, hence why I have them as a separate constant.
    // Window in javascript means the space where all scripts, elements and css get rendered.
    // Location means where in the DOM is the window rendering.
    const topNavbar = document.getElementById("topnavbar");
    const topnavbarBtns = JSON.parse(topnavbar.dataset.navbtns);

    topNavbar.innerHTML = Logo()

    topnavbarBtns.forEach((element)=> {   

    let button = document.createElement("button"); 
    button.innerHTML = element; 
    topNavbar.appendChild(button);
    
    button.addEventListener("click", function(){window.location.href = `${button.innerHTML}.html`.toLowerCase()})


    })
}

async function MediaContainer(){
    const jsonFile = await fetch('JSONS/News/media.json');
    const jsonString = await jsonFile.text();
    const data = JSON.parse(jsonString);

    let mediaContainter = document.getElementsByClassName("mediaContainer")

    for(let i = 0; i < mediaContainter.length; i++) {
        data[`mediaContainter${i+1}`].forEach((element) => {
            if(element.markup.startsWith("videos")){
                mediaContainter[i].innerHTML = video(element.markup)
            } else {
                mediaContainter[i].innerHTML = emptyImg(element.markup,"50px", "50px")
            }
        })
    }
}

// The first number when incrementing though zindexes is 0.
// Seems like -0 is a number that is high in priority isntead of being just 0.
// Putting -1 there means that the zindex incrementation start from -1 instead of -0.
// For some reason, forEach doesn't work but a regular for loop does.
function Panels() {
    let panel = document.getElementsByClassName("panel");

    for(let i = 0; i < panel.length; i++) {
        panel[i].style.backgroundColor = Coloralgo(panel[i].dataset.color);
        panel[i].style.filter = ShadowColoralgo(panel[i].dataset.color);
        panel[i].style.zIndex = -i-1;
    }
}

// Async marks the function to say that it will run within it's own time and will not interupt any other code.
// Await ensures data and will come soon (like downloading a file).
async function PanelGrid() {
    const jsonFile = await fetch('JSONS/News/cards.json');
    const jsonString = await jsonFile.text();
    const data = JSON.parse(jsonString);

    const panelGrid = document.getElementsByClassName("panelGrid")

     for(let i = 0; i < panelGrid.length; i++) {
        let panelKey = `Panel${i + 1}`;
        data[panelKey].forEach((element) => {
        let card = document.createElement("div")
        card.classList.add("panelCard")
        card.innerHTML = PanelCard(element.title,element.date,element.description, element.image, "260vw", "260vw")
        panelGrid[i].appendChild(card)
        })
    }      
}

function PanelCard(title,date,info, file,width,height){
    return `
            <img src=${file} width=${width} height=${height}></img>
            <div class=info>
                <h2>${title}</h2>
                <p>${date}</p>
                <p>${info}</p>
                <button>Read More</button>
            </div>
            `
}

function Logo() {
    return '<img src="images/logo.jpg" width="70px" height="70px"></img>'
}

function video(source) {
    return `<video controel="false" autoplay="true" loop="true" class="introduction" muted="true"><source src=${source} type="video/mp4"></source></video>`
}

function Heading(heading) {
    return '<h1>${heading}</h1>'
}

function Subheading(subheading) {
    return '<p>${subheading}</p>'
}

function emptyImg(file,width,height) {
    let image = `<img src=${file} width=${width} height=${height}></img>`
    return image
}

//Short for color algorithm.
// Cannot be achieved with CSS.
function Coloralgo(nodestr) {

    switch(nodestr.toLowerCase()) {
        case "red":
            return "var(--red)"
        case "darkred":
            return "var(--redshadow)"
        case "blue":
            return "var(--blue)"
        case "yellow":
            return "var(--yellow)"
        case "white":
            return "var(--white)"
    }
}

function ShadowColoralgo(nodestr) {

    switch(nodestr.toLowerCase()) {
        case "red":
            return 'drop-shadow(0px 30px 0px var(--redshadow))'
        case "darkred":
            return 'drop-shadow(0px 30px 0px var(--darkredshadow))'
        case "blue":
            return 'drop-shadow(0px 30px 0px var(--blueshadow))'
        case "yellow":
            return 'drop-shadow(0px 30px 0px var(--yellowshadow))'
        case "white":
            return 'drop-shadow(0px 30px 0px var(--whiteshadow))'
    }
}

TopNavBar()
Navbar()
MediaContainer()
Panels()
PanelGrid()