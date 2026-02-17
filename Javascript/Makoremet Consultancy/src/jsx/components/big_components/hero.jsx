// Small Components.
import Makoremet from '../small_components/makoremet.jsx'

function Hero() {
    return (
        <>
        <div className='hero'>
            <h1> Need Help With XYZ? <Makoremet size="60px" color="var(--default-green)"></Makoremet> is the thing for you  </h1>
        </div>

        <p className='herograph'> Makoremet is a metallurgical consultancy where we do x,y, and z</p>

        {/* Just remember that this navbuttons has the same properties as the other navbuttons*/}
        <div className="herobuttons">
            <button>About Us</button>
            <button> Chat with Us</button>
        </div>
        </>
    )
}

export default Hero