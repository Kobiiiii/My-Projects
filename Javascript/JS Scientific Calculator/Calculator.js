const buttons = document.querySelectorAll("button")
const screenOutput = document.querySelector("p")
const clearButton = document.getElementById("ac")
const equals = document.getElementById("equals")

const mummy = document.getElementsByClassName("calcScreen")

// To save every single trigonometry function.
let trigs = []
let endPars = 0

let calcReady = true

let possibleSquare = ""

const currentChar = screenOutput.innerHTML[screenOutput.innerHTML.length - 1]
const previousChar = screenOutput.innerHTML[screenOutput.innerHTML.length - 2] 



//Giving every button a function
for (let i = 0; i < buttons.length; i++){
    if (buttons[i].innerHTML != "="){
    buttons[i].onclick = function() {output(buttons[i].innerHTML)}
    }

    if (isOperator(buttons[i].innerHTML)) {
        //buttons[i].style.backgroundColor = "#2e1f5f"
    } 
}




// This disables or enables the x²,x³,x!, and % buttons dependant on if there is a number behind them.
// disable these buttons first to prevent the concat issue.
buttons[25].disabled = true //x²
buttons[26].disabled = true //x³
buttons[29].disabled = true //x!
buttons[30].disabled = true //%

// Equals button event.
equals.onclick = function() {calculate()};

// Mouse follow element event.
//function follow(event) {
   // var light = document.getElementById('mouse');
   //light.style.left = (event.clientX - light.offsetWidth/2) + 'px';
    //light.style.top = (event.clientY - light.offsetHeight/2) + 'px';
//}

//document.addEventListener('mousemove', follow);

// Detects input of a button pressed and then outputs it on the screen.
function output(input) {

    // The equation to know the previous character of a sting is string[string.length - 2].
    const previousChar = screenOutput.innerHTML[screenOutput.innerHTML.length - 2] 

    // The equation to know the previous character of a sting is string[string.length - 1].
    const currentChar = screenOutput.innerHTML[screenOutput.innerHTML.length - 1]

        // The two operator rule.
        if (isOperator(currentChar) && isOperator(input)) {
            //0 is the beginning of the string.
            //-1 is the last character of the string.
            //The line below gets rid of the latest character and then replace it with the input.
            screenOutput.innerHTML = screenOutput.innerHTML.slice(-1) + input;
            
        } else {
            screenOutput.innerHTML = screenOutput.innerHTML.concat(input)
        }
    
    // These lines are for the possibleSquare variable.
    // We square the numbers that are saved in the variable.
        if (isNum(input)) {
            possibleSquare = possibleSquare.concat(input)
        } else if (!isNum(input) && !isPower(input)) { // Just so the variable doesn't erase when x² is pressed.
            possibleSquare = ""
        }

        if (screenOutput.innerHTML.startsWith("0") && !isOperator(input) && calcReady == true) {
            const wordLength = screenOutput.innerHTML.length - 1
            screenOutput.innerHTML = screenOutput.innerHTML.slice(-wordLength)
        } else {
            // Leave this here or you will experience that 0+6 problmen agains
            calcReady = false
        }

        // So I can add the open bracket to any functions.
        // The reason why I don't use html is because they need a closing parenthesis.
        if (isScientific(input)) {
            trigs.push(input)

            screenOutput.innerHTML = screenOutput.innerHTML.concat("(")
        }

        // Just simply checking the √ character so that it can be added to the trigs array.
        if (input == "√" ){
            trigs.push("sqrt")
        }

        if (input.includes("³√")){
            trigs.push("cbrt")
        }


        // I tried counting how many ) there were in the string but it just didn't work.
        // I am instead going to count by using an integer.
        if (input == ")") {
            endPars += 1
        }


        if (input.includes("x²") && possibleSquare != "") {
            let lastIndex = screenOutput.innerHTML.lastIndexOf(possibleSquare)

            screenOutput.innerHTML = screenOutput.innerHTML.substring(0,lastIndex) + possibleSquare ** 2
            screenOutput.innerHTML = screenOutput.innerHTML.replace("x²", "")
            possibleSquare = ""

        }

        if (input.includes("x³") && possibleSquare != "") {
            let lastIndex = screenOutput.innerHTML.lastIndexOf(possibleSquare)

            screenOutput.innerHTML = screenOutput.innerHTML.substring(0,lastIndex) + possibleSquare ** 3
            screenOutput.innerHTML = screenOutput.innerHTML.replace("x³", "")
            possibleSquare = ""
        }

        if (input == "x!") {
            screenOutput.innerHTML = screenOutput.innerHTML.replace("x!", "!")
        }

        if (isNum(input)) {
            enableSpecButtons()
        } else {
            disableSpecButtons()
        }

        // To stop the user to typing any more operators if they input operator with a - after.
        // To prevent - in being inputted twice, we will disable operator buttons also.
        if (isOperator(currentChar) && input == "-" || input == "-"){
            for(let i = 0; i < buttons.length; i++) {
                if(isOperator(buttons[i].innerHTML)) {
                    buttons[i].disabled = true
                } 
            }
        } else {
            for(let i = 0; i < buttons.length; i++) {
                if(isOperator(buttons[i].innerHTML)) {
                    buttons[i].disabled = false
                } 
            }
        }
} 

// This will be either true or false if the character is an operator.
// For example: isOperator("+") would be true as it's in the array.
// good to use if you want to check if something is in a certain category.
function isOperator(char) {
    return ["+", "-", "x","÷"].includes(char);
}

function isNum(char) {
    return ["1", "2", "3","4","5","6","7","8","9","0"].includes(char);
}

function isScientific(char) {
    return ["cos","sin","tan","sqrt", "log", "round","cbrt"].includes(char)
}

function isPower(char) {
    return ["x²","x³"].includes(char)
}

function disableSpecButtons() {
    buttons[25].disabled = true //x²
    buttons[26].disabled = true //x³
    buttons[29].disabled = true //x!
    buttons[30].disabled = true //%
}

function enableSpecButtons() {
    buttons[25].disabled = false //x²
    buttons[26].disabled = false //x³
    buttons[29].disabled = false //x!
    buttons[30].disabled = false //%
}

// Onclick event for the clear button.
clearButton.onclick = function() {clearScreen()}

// Clears the screen when ac is pressed.
function clearScreen() {
    // Resetting all of the needed variables.
    screenOutput.innerHTML = "0"
    calcReady = true
    trigs = []
    endPars = 0
    possibleSquare = ""

    for(let i = 0; i < buttons.length; i++) {
        if(isOperator(buttons[i].innerHTML)) {
            buttons[i].disabled = false
        } 
    }
}

function calculate() {

    try { // Try allows javaScript to run whatevers in the block.
    // As i am using inner HTML to calculate, I
    switch (true) {
        case screenOutput.innerHTML.includes("x"): screenOutput.innerHTML = screenOutput.innerHTML.replaceAll("x", "*")
            break;

        case screenOutput.innerHTML.includes("÷"): screenOutput.innerHTML = screenOutput.innerHTML.replaceAll("÷", "/")
            break;
        
        case screenOutput.innerHTML.includes("√"):
            if (screenOutput.innerHTML.includes("³")) {
                screenOutput.innerHTML = screenOutput.innerHTML.replaceAll("³√", "cbrt(")
            } else {
                screenOutput.innerHTML = screenOutput.innerHTML.replaceAll("√", "sqrt(")
            }
            break;
        
        case screenOutput.innerHTML.includes("π"): screenOutput.innerHTML = screenOutput.innerHTML.replaceAll("π", "3.14159265359")
            break;
    }
    

    // I put this under that "endParenthesis" function but that didn't work?
    // For all triganomic functions, they need an end parenthesis for the calculation to work.
    // If there isn't one then the calculator will send an error.
    // There is an array called "trigs" so we know how many trig functions there are on diplay.
    // Result allows us to know how many end parenthesis need to be put down automatically.
    let result = trigs.length - endPars

    while (result > 0) {
        screenOutput.innerHTML = screenOutput.innerHTML.concat(")")
        result -= 1
    }
    
    // When math.js was imported, it automatically creates an object called "math".
    // In JS libraries, there might be objects you might have to reffer to access all of the methods and properies.
    screenOutput.innerHTML = math.evaluate(screenOutput.innerHTML)
    screenOutput.style.animation = "answered 3s 1"
    } catch(error) { // and if there is an error in the try block then the catch block will run.
        if (error instanceof EvalError) { // There are so many different errors out there so checking if theres an eval error is important.
            screenOutput.innerHTML = "Error"
        } else {
            screenOutput.innerHTML = "Error"
        }
    }
 } 
