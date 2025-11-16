function Navbar() {
    // Gethering navbar.
    // JSON.parse means to turn the string into data that can be executed by code.
    // For some unknown reason, the elements have been appended in reverse.
    // So reversing the array even though its in the right order works.
    const navbar = document.getElementById("navbar");
    const centerbar = document.getElementById("centerbar");
    const centerbarBtns = JSON.parse(navbar.dataset.buttons);
    centerbarBtns.reverse()

    centerbarBtns.forEach((element)=> {
        centerbar.insertAdjacentHTML("afterbegin", Button(element,element))
    })

    centerbar.childNodes.forEach((child) => {
        if(child.innerHTML.includes("Home")) {
            child.innerHTML = `<a href="index.html">Home</a>`
        }
    })
}

async function ScheduleGrid() {
    const file = await fetch('JSON/schedule.json')
    const fileText = await file.text()
    let content = JSON.parse(fileText)

    const scheduleGrids = window.location.pathname == "/index.html" ? document.getElementsByClassName("scheduleSlider") : document.getElementsByClassName("scheduleGrid")

    content[`${window.location.pathname}`].forEach((element) => { 
        scheduleGrids[0].insertAdjacentHTML("afterbegin", 
        ScheduleCard(element.game,element.time,element.title,element.location,element.team1,element.team2))
    })
}

function ScheduleCard(game,time,title,location,team1,team2) {
    return `<div class="scheduleCard">
 
       <div class="cardHead">
          <div class="gameTag" id=${game}><img src=images/${game}.svg width="20px">Overwatch 2</div>
          <div class="times">${time}</div>
       </div>
 
       <div class="cardBody">
          <div class="name">${title}</div>
          <div class="location">${location}</div>
       </div>
 
       <div class="cardFoot">
         <div class="team">${team1}</div>
         <div class="vs">Vs.</div>
         <div class="team">${team2}</div>
       </div>
    </div>`
}


async function EventGrid() {
    const file = await fetch('JSON/events.json')
    const fileText = await file.text()
    let content = JSON.parse(fileText)

    const eventGrids = window.location.pathname == "/index.html" ? document.getElementsByClassName("eventSlider") : document.getElementsByClassName("eventGrid") 

    content[`${window.location.pathname}`].forEach((element) => { 
        eventGrids[0].insertAdjacentHTML("afterbegin", EventCard(element.statement,element.src))
    })

}

function EventCard(statement,src) {
    return `
        <div class="eventCard">
            ${Overlay()}
            <img src=${src} class="introduction"></img>
            <div class="statement">${statement}</div>
        </div>`

}

async function ShopGrid() {
    const file = await fetch('JSON/shop.json')
    const fileText = await file.text()
    let content = JSON.parse(fileText)

    const shopGrids = document.getElementsByClassName("slider")

    content[`${window.location.pathname}`].forEach((element) => { 
        shopGrids[0].insertAdjacentHTML("afterbegin", 
        ShopCard(element.src,element.name,element.category,element.price))
    })
    
}

function ShopCard(src,name,category,price) {
    return `
       <div class="shopCard">
        <div class="itemImg"><img src=${src}></img></div>
        <div class="itemName">${name}</div>
        <div class="itemCategory">${category}</div>
        <div class="price">${price}</div>
       </div>`
}

function MemberCard(src, name, role) {
    return ` 
    <div class="memberCard">
      <div class="overlay"></div>
      <img src=${src}></img>
      <div class="name">${name}</div>
      <div class="role">${role}</div>
    </div>`

}

async function TeamGrid() {
    const file = await fetch('JSON/team.json')
    const fileText = await file.text()
    let content = JSON.parse(fileText)

    const teamGrids = document.getElementsByClassName("teamSlider")

    content[`overwatch`].forEach((element) => { 
        teamGrids[0].insertAdjacentHTML("afterbegin", 
        MemberCard(element.src,element.name,element.role))
    })
    
}

// HTMLcollection is not an array but is an object that can be iterated through like an array.
// HTMLcollection doesn't have array methods.
// Array.from turns iterable objects into an array.
async function Container() {
    const file = await fetch('./JSON/containers.json')
    const fileText = await file.text()
    let content = JSON.parse(fileText)

    // Grabbing all containters.
    const containers =  document.getElementsByClassName("container")

    // Every content JSON request looks like multiple array queries for string interpolation reasons.
    // Remember: every array object in containers.json should be the same pathname as the html page name.
    for(i=0; i<=containers.length; i++){
        containers[i].insertAdjacentHTML("afterbegin", Heading(content[`${window.location.pathname}`][i].title))
        containers[i].insertAdjacentHTML("afterbegin", Subheading(content[`${window.location.pathname}`][i].subtitle))
        containers[i].insertAdjacentHTML("afterbegin", Content(content[`${window.location.pathname}`][i].src))
        containers[i].insertAdjacentHTML("afterbegin", Overlay())
    }

}

function imageDetection(src) {
    return src.startsWith("images")
}

function Content(src) {
        return imageDetection(src) ? `<img class="introduction" src=${src}></img>` 

    :`<video controle="false" autoplay="true" loop="true" class="introduction" muted="true" >
        <source src=${src} type="video/mp4">
        <track kind="subtitles" srclang="en" label="English">
      </video>`
}

function Button(name, link) {
    return `<button><a href=${link.toLowerCase()}.html>${name}</a></button>`
}

function Heading(heading) {
    return `<div class="heading">${heading}</div>`
}

function Subheading(subheading) {
    return `<div class="subheading">${subheading}</div>`
}

function Statement(statement) {
    return `<div class="statement">${statement}</div>`
}

function Overlay() {
    return `<div class="overlay"></div>`
}


Container()
Navbar()
ScheduleGrid()
EventGrid()
ShopGrid()
TeamGrid()