const buttons = document.querySelectorAll("button")
const screen = document.getElementById("calcScreen")
const screenOutput = screen.querySelector("h1")
const clearButton = document.getElementById("ac")
const equals = document.getElementById("equals")

const currentChar = screenOutput.innerHTML[screenOutput.innerHTML.length - 1]

let limit = 9

// Giving every button a function
for (let i = 0; i < buttons.length; i++){
    if (buttons[i].innerHTML != "="){
    buttons[i].onclick = function() {output(buttons[i].innerHTML)}
    }

    if (isOperator(buttons[i].innerHTML)) {
        buttons[i].style.backgroundColor = "#2e1f5f"
    }
}

// Equals button event.
equals.onclick = function() {calculate()}

// Detects input of a button pressed and then outputs it on the screen.
function output(input) {

    if (limit < 0) {
        screenOutput.style.transform += "translateX(-15px)"
    }

    // The equation to know the previous character of a sting is string[string.length - 2].
    const previousChar = screenOutput.innerHTML[screenOutput.innerHTML.length - 2] 

    // The equation to know the previous character of a sting is string[string.length - 1].
    const currentChar = screenOutput.innerHTML[screenOutput.innerHTML.length - 1]

        if (isOperator(currentChar) && isOperator(input)) {
            //0 is the beginning of the string.
            //-1 is the last character of the string.
            //The line below gets rid of the latest character and then replace it with the input.
            screenOutput.innerHTML = screenOutput.innerHTML.slice(0,-1) + input;
        } else {
            // just so the character limit goes down.
            limit -= 1
            screenOutput.innerHTML = screenOutput.innerHTML.concat(input)
        }

        if (screenOutput.innerHTML.startsWith("0") && isNum(input)) {
            screenOutput.innerHTML = screenOutput.innerHTML.slice(-1);
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

// Onclick event for the clear button.
clearButton.onclick = function() {clearScreen()}

// Clears the screen when ac is pressed.
function clearScreen() {
    screenOutput.innerHTML = "0"

    for(let i = 0; i < buttons.length; i++) {
        if(isOperator(buttons[i].innerHTML)) {
            buttons[i].disabled = false
        } 
    }
}

function calculate() {

    try { // Try allows javaScript to run whatevers in the block.
    // As i am using inner HTML to calculate, I
    if (screenOutput.innerHTML.includes("x"))
        {
            screenOutput.innerHTML = screenOutput.innerHTML.replaceAll("x", "*")
        }
    
    if (screenOutput.innerHTML.includes("÷"))
        {
            screenOutput.innerHTML = screenOutput.innerHTML.replaceAll("÷", "/")
        }

    screenOutput.innerHTML = eval(screenOutput.innerHTML)
    } catch(error) { // and if there is an error in the try block then the catch block will run.
        if (error instanceof EvalError) { // There are so many different errors out there so checking if theres an eval error is important.
            screenOutput.innerHTML = "Error"
        } else {
            screenOutput.innerHTML = "Error"
        }
    }
 } 