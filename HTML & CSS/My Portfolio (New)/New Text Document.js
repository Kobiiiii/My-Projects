// To get the head of every card.
const cardHead = document.getElementsByClassName("cardHead");

// To get the content of every card.
const cardContent = document.getElementsByClassName("cardContent");

const card = document.getElementsByClassName("card");

//const cardHeadX = cardHeadMatrix.x + "px"
//const cardHeadY = cardHeadMatrix.y + "px"
//const cardHeadHeight = cardHead.offsetHeight + "px"

// Making sure that every card head is the same length as the image.
for (let i = 0; i < cardContent.length; i++) {
    const cardContentCS = window.getComputedStyle(cardContent[i])
    const cardContentWidth = cardContentCS.width
    cardHead[i].style.width = cardContentWidth
}


// Apparently 70 pixels makes the card content below the card head.
// Not to mention how the card content is magically in the same x position as the card head.


// For the titles.
const titles = document.getElementById("Titles")
const titlesArr = ["Game Developer", "Pixel Artist", "Musician", "UX/UI Designer", "Loves Kirby"]
window.setInterval(slideShow,5000) //Set interval cllas the fuction every time.


function slideShow() {
    // Opacity is a transistion, thats why it's smooth.
    titles.style.opacity = 0

    titles.ontransitionend = () => {
        if (titles.style.opacity == 0){
            const index = titlesArr.indexOf(titles.innerHTML) //Title.innerHTML is the current index of the titles array.
            titles.innerHTML = titlesArr[index + 1] //Scrollling through the titles array.
            titles.style.opacity = 1
            //To got back to the beginning of the array.
            if (index == titlesArr.length - 1) {
                titles.innerHTML = titlesArr[0]
            }
        }
    }
}
